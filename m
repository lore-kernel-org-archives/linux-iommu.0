Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D8CC433DF
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 01:10:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7B7208E4
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 01:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqDshH4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7B7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D89A388616;
	Fri, 31 Jul 2020 01:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GILAocBjTcON; Fri, 31 Jul 2020 01:10:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C2E1588606;
	Fri, 31 Jul 2020 01:10:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2F1EC0050;
	Fri, 31 Jul 2020 01:10:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C8C1C004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 01:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1E3902152C
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 01:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2phHv-YVio4m for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 01:10:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 91D802079D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 01:10:07 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id h7so27432659qkk.7
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jul 2020 18:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=D6NBoB2E2UORS0vxwFp8hCbO3jjocLGEsRaBZ4a3Cu4=;
 b=nqDshH4ZBAcngsPAU2XSpK4c1TSV88FwXn5DlgyeDI8nu7ey04jFVxwnFLkRdjwSXG
 toTR9/WFPA8rxWJzaYI9B3unVGHta9RBT2AMp/Ey5yhPZ8JYEs18saczm2dQE5mYOVM8
 lCqlHDGjmLKaaORk8aO94HGwStmn0pEWkQymZxIKriGc0pUJjdW4jwNve8RUvmH+QKD8
 DnzxDW3/N49NftucOXHqEehPHiDbmFIcNX7kQJpRCxrXpDjbu5gIA23lFumCYJNL19QI
 hv56EMoKJ5rnzG1HGjKk+QRG0KnOS+4VxqcEy4I+i9TjVnoOiaoRSFULBf4y6mz3kAV2
 F0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D6NBoB2E2UORS0vxwFp8hCbO3jjocLGEsRaBZ4a3Cu4=;
 b=miiWO3Nl57Xcn61kOyzypyOIV1ET7jB5y3WKFe5nnQ5nBEEMHjp6MzKlPKnUTD4GNv
 o5rQkYuR9EvAxBvwhNbItKMQaM8RhrOIZInnSRQrbu6LxJpa5sPh2mBItNXZYubZFmd2
 QQoo9k18/sWH1kScRX3Mt6EjkVgq2Fn4ix3ABXhzXf7iytB1TS14vWaVt9PwQozYZbAk
 QeVoR80s92cozXr9r45pajs37XgOObCOADp8FhDiTgUT7yQh9nVvKWrobALJDZndYTUw
 etRr1GXeExEyq8RmJOde62MMp/BqboM7lwlepXZ1VD/RUSs/BdjvQwZnR9FKM8HJRbrn
 d2oA==
X-Gm-Message-State: AOAM533dseUNka/51Ns4oPTVBxh7fD+ENBvBnfkIMI7XqU+pwffYbiQJ
 RLX37baCXmOsyQB+yFBZ6NA=
X-Google-Smtp-Source: ABdhPJwN6gFxZXDSUFRTCXi75SujGs/2puXt91yJ2XyQrWshXyFhR/atb9neFueWVXKBE85TvpPxeA==
X-Received: by 2002:a37:54a:: with SMTP id 71mr1818899qkf.193.1596157806411;
 Thu, 30 Jul 2020 18:10:06 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
 by smtp.gmail.com with ESMTPSA id c205sm6137184qkg.98.2020.07.30.18.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 18:10:05 -0700 (PDT)
Date: Thu, 30 Jul 2020 18:10:04 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
Message-ID: <20200731011004.GA729998@ubuntu-n2-xlarge-x86>
References: <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com>
 <6db722947546221ed99d3f473f78e1a6de65d7d6.camel@suse.de>
 <CAMi1Hd0Xz6kOJFpA5PEpi6RDDGOcz0RmQ7tTOkuXq4QneOO_vQ@mail.gmail.com>
 <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de>
 <CAMi1Hd3O2HHBsnt=sac7FdcW0-3=4S3g_F9f__2h5gTsudfirA@mail.gmail.com>
 <20200724134114.GA3152@lst.de>
 <a9b811a84ac21c13693e6ffefd2914b911542e18.camel@suse.de>
 <20200728091335.GA23744@lst.de>
 <e39e8f87ed5b4e9da2f08a0651801954e61f4b4e.camel@suse.de>
 <20200728100918.GA26364@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200728100918.GA26364@lst.de>
Cc: Amit Pundir <amit.pundir@linaro.org>, lkml <linux-kernel@vger.kernel.org>,
 jeremy.linton@arm.com, iommu@lists.linux-foundation.org,
 John Stultz <john.stultz@linaro.org>, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
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

On Tue, Jul 28, 2020 at 12:09:18PM +0200, Christoph Hellwig wrote:
> Ok, I found a slight bug that wasn't intended.  I wanted to make sure
> we can always fall back to a lower pool, but got that wrong.  Should be
> fixed in the next version.

Hi Christoph and Nicolas,

Did a version of that series ever get send out? I am coming into the
conversation late but I am running into an issue with the Raspberry Pi 4
not booting on linux-next, which appears to be due to this patch now in
mainline as commit d9765e41d8e9 ("dma-pool: do not allocate pool memory
from CMA") combined with
https://lore.kernel.org/lkml/20200725014529.1143208-2-jiaxun.yang@flygoat.com/
in -next:

[    1.423163] raspberrypi-firmware soc:firmware: Request 0x00000001 returned status 0x00000000
[    1.431883] raspberrypi-firmware soc:firmware: Request 0x00030046 returned status 0x00000000
[    1.443888] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.452527] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 0 config (-22 80)
[    1.460836] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.469445] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 1 config (-22 81)
[    1.477735] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.486350] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 2 config (-22 82)
[    1.494639] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.503246] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 3 config (-22 83)
[    1.511529] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.520131] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 4 config (-22 84)
[    1.528414] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.537017] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 5 config (-22 85)
[    1.545299] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.553903] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 6 config (-22 86)
[    1.562184] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.570787] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 7 config (-22 87)
[    1.579897] raspberrypi-firmware soc:firmware: Request 0x00030030 returned status 0x00000000
[    1.589419] raspberrypi-firmware soc:firmware: Request 0x00028001 returned status 0x00000000
[    1.599391] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.608018] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 1 config (-22 81)
[    1.616313] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.624932] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 1 config (-22 81)
[    1.633195] pwrseq_simple: probe of wifi-pwrseq failed with error -22
[    1.643904] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.652544] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 2 config (-22 82)
[    1.660839] raspberrypi-firmware soc:firmware: Request 0x00030041 returned status 0x00000000
[    1.669446] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 2 state (-22 82)
[    1.677727] leds-gpio: probe of leds failed with error -22
[    1.683735] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.692346] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 6 config (-22 86)
[    1.700636] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.709240] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 6 config (-22 86)
[    1.717496] reg-fixed-voltage: probe of sd_vcc_reg failed with error -22
[    1.725546] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.734176] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 4 config (-22 84)
[    1.742465] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.751072] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 4 config (-22 84)
[    1.759332] gpio-regulator: probe of sd_io_1v8_reg failed with error -22
[    1.768042] raspberrypi-firmware soc:firmware: Request 0x00028001 returned status 0x00000000
[    1.780871] ALSA device list:
[    1.783960]   No soundcards found.
[    1.787633] Waiting for root device PARTUUID=45a8dd8a-02...

I am unsure if it is related to the issue that Amit is having or
if that makes sense at all but I can reliably reproduce it.

v5.8-rc1: OK
v5.8-rc1 + d9765e41d8e9e: OK
v5.8-rc1 + "of_address: Add bus type match for pci ranges parser": OK
v5.8-rc1 + both: BROKEN

I wanted to test the series to see if this fixes anything. If you would
prefer a different thread for this or further information, please let
me know.

Cheers,
Nathan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
