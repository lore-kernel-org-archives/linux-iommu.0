Return-Path: <SRS0=kesm=FP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D88C4167B
	for <iommu@archiver.kernel.org>; Fri, 11 Dec 2020 06:35:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A95823EF1
	for <iommu@archiver.kernel.org>; Fri, 11 Dec 2020 06:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A95823EF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9E1988726D;
	Fri, 11 Dec 2020 06:35:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uIsC43i35RfQ; Fri, 11 Dec 2020 06:34:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C624E8725E;
	Fri, 11 Dec 2020 06:34:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FB14C013B;
	Fri, 11 Dec 2020 06:34:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F1A6C013B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Dec 2020 06:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F423C2741E
 for <iommu@lists.linux-foundation.org>; Fri, 11 Dec 2020 06:34:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OpPEAuI1Gf6y for <iommu@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 06:34:54 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.7.6
Received: from m43-15.mailgun.net (m43-15.mailgun.net [69.72.43.15])
 by silver.osuosl.org (Postfix) with ESMTPS id CE9C227400
 for <iommu@lists.linux-foundation.org>; Fri, 11 Dec 2020 06:34:53 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1607668493; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=CBvvLpwtaE+gzzGXyeEU08iu5LD1yReJKAJiYh9JYE0=;
 b=eOFw659ApkBmp6+kssTGWaZTxaHzxi6UOrPUzIiaQtG1R+GU7vU4OhoZdrpJiTnbtzDHAyH2
 9Scf8aIwW/QeFoHKlzKC91499362DgbxRGfc2GA9X2L3tf8ydczXBROTVCpU17UDuhlh7+64
 brlL1rYWku+1VZ1Hp8gAkQxx0M0=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fd311dffa3411972bb5c7d5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 06:29:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 5E085C43469; Fri, 11 Dec 2020 06:29:50 +0000 (UTC)
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi
 [88.114.240.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: kvalo)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id DE4EFC433ED;
 Fri, 11 Dec 2020 06:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE4EFC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] dma-mapping: move hint unlikely for dma_mapping_error
 from drivers to core
References: <5d08af46-5897-b827-dcfb-181d869c8f71@gmail.com>
Date: Fri, 11 Dec 2020 08:29:24 +0200
In-Reply-To: <5d08af46-5897-b827-dcfb-181d869c8f71@gmail.com> (Heiner
 Kallweit's message of "Thu, 10 Dec 2020 15:47:50 +0100")
Message-ID: <87eejw97p7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Cc: Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
 Igor Russkikh <irusskikh@marvell.com>,
 Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 GR-everest-linux-l2@marvell.com, Ioana Radulescu <ruxandra.radulescu@nxp.com>,
 Madalin Bucur <madalin.bucur@nxp.com>, Michal Simek <michal.simek@xilinx.com>,
 Doug Ledford <dledford@redhat.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Jiri Pirko <jiri@resnulli.us>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>,
 Arnaud Ebalard <arno@natisbad.org>,
 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guy Tzalik <gtzalik@amazon.com>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-crypto@vger.kernel.org, Shannon Nelson <snelson@pensando.io>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Chris Snook <chris.snook@gmail.com>, Daniele Venzano <venza@brownhat.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, linux-i2c@vger.kernel.org,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jon Olson <jonolson@google.com>,
 Arthur Kiyanovski <akiyano@amazon.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Rain River <rain.1986.08.12@gmail.com>,
 Martin Habets <habetsm.xilinx@gmail.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Wingman Kwok <w-kwok2@ti.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Kevin Br ace <"kev inbrace"@bracecomputerlab.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Pensando Drivers <drivers@pensando.io>, linux-arm-kernel@lists.infradead.org,
 Boris Brezillon <bbrezillon@kernel.org>, Sagi Shahar <sagis@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Netanel Belgazal <netanel@amazon.com>, Andreas Larsson <andreas@gaisler.com>,
 Catherine Sullivan <csully@google.com>,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 Alexei Starovoitov <ast@kernel.org>, Elie Morisse <syniurge@gmail.com>,
 Luca Coelho <luciano.coelho@intel.com>,
 Quan Nguyen <quan@os.amperecomputing.com>,
 Subb araya Su ndeep <sbhatta@marvell.com>, Jiri Slaby <jirislaby@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, Srujana Challa <schalla@marvell.com>,
 ath10k@lists.infradead.org, b43-dev@lists.infradead.org,
 ath11k@lists.infradead.org, Jay Cliburn <jcliburn@gmail.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
 John Crispin <john@phrozen.org>, Michael Chan <michael.chan@broadcom.com>,
 Edward Cree <ecree.xilinx@gmail.com>, iommu@lists.linux-foundation.org,
 wil6210@qti.qualcomm.com, Saeed Bishara <saeedb@amazon.com>,
 bpf@vger.kernel.org, Geetha sowjanya <gakula@marvell.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Zorik Machulsky <zorik@amazon.com>,
 qat-linux@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Nick Kossifidis <mickflemm@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Nehal Shah <nehal-bakulchandra.shah@amd.com>,
 Sunil Goutham <sgoutham@marvell.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Ariel Elior <aelior@marvell.com>, Keyur Chudgar <keyur@os.amperecomputing.com>,
 George Cherian <gcherian@marvell.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 hariprasad <hkelam@marvell.com>, Raju Rangoju <rajur@chelsio.com>,
 Felix Fietkau <nbd@nbd.name>, Saeed Mahameed <saeedm@nvidia.com>,
 Larry Finger <Larry.Finger@lwfinger.net>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Zillions of drivers use the unlikely() hint when checking the result of
> dma_mapping_error(). This is an inline function anyway, so we can move
> the hint into the function and remove it from drivers.
>>From time to time discussions pop up how effective unlikely() is,
> and that it should be used only if something is really very unlikely.
> I think that's the case here.
>
> Patch was created with some help from coccinelle.
>
> @@
> expression dev, dma_addr;
> @@
>
> - unlikely(dma_mapping_error(dev, dma_addr))
> + dma_mapping_error(dev, dma_addr)
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> If ok, then tbd through which tree this is supposed to go.
> Patch is based on linux-next-20201210.
> ---

[...]

>  drivers/net/wireless/ath/ath10k/htt_rx.c      |  2 +-
>  drivers/net/wireless/ath/ath10k/pci.c         |  2 +-
>  drivers/net/wireless/ath/ath10k/snoc.c        |  2 +-
>  drivers/net/wireless/ath/ath11k/ce.c          |  2 +-
>  drivers/net/wireless/ath/ath11k/dp_rx.c       |  2 +-
>  drivers/net/wireless/ath/ath5k/base.c         |  2 +-
>  drivers/net/wireless/ath/ath9k/beacon.c       |  2 +-
>  drivers/net/wireless/ath/ath9k/recv.c         | 21 +++++++---------
>  drivers/net/wireless/ath/ath9k/xmit.c         |  2 +-
>  drivers/net/wireless/ath/wil6210/txrx.c       | 10 ++++----
>  drivers/net/wireless/ath/wil6210/txrx_edma.c  |  4 +--
>  drivers/net/wireless/broadcom/b43/dma.c       |  2 +-
>  drivers/net/wireless/broadcom/b43legacy/dma.c |  2 +-
>  drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 10 ++++----
>  drivers/net/wireless/intel/iwlwifi/queue/tx.c | 10 ++++----
>  drivers/net/wireless/mediatek/mt76/dma.c      |  8 +++---
>  .../net/wireless/ralink/rt2x00/rt2x00queue.c  |  4 +--

For wireless drivers:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
