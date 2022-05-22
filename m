Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD2DC4332F
	for <iommu@archiver.kernel.org>; Sun, 22 May 2022 22:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF63060ACC;
	Sun, 22 May 2022 22:22:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e3voJPeb6kpK; Sun, 22 May 2022 22:22:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AB1E661003;
	Sun, 22 May 2022 22:22:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A6A7C0032;
	Sun, 22 May 2022 22:22:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E6E7C002D
 for <iommu@lists.linux-foundation.org>; Sun, 22 May 2022 22:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 652F060FFF
 for <iommu@lists.linux-foundation.org>; Sun, 22 May 2022 22:22:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fPdNDWKx514L for <iommu@lists.linux-foundation.org>;
 Sun, 22 May 2022 22:22:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92DF660ACC
 for <iommu@lists.linux-foundation.org>; Sun, 22 May 2022 22:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653258161; x=1684794161;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=g7+JeN4wnrl6dFXGk3nhuKNxU3bxTCBHH+iqteHxNFE=;
 b=aiG7A8mIQ/6LTz1MFnlwjLHAuXEeXKHQtQVPNeAVkmktwPVI4JCFvEY4
 FwC+jBTZ5wNkAl2Vh3ALSggdKJuWW+gY/fO0hqMMCSSEn44isE2UogOY7
 TxUs+aZywUMnJLvYcGTfglyjei7wwZTrHpgdxG7zbIa9Vm43W+cmWPpdo
 jyWzDg3HE/mk6RY8JndtcE/dud+3cRiYKiDv+UVQKaF1sufu1WyO+lksW
 ubyN8hYbilMhYnmNdIm/XgvoMl7V7FVTahHALl7MXZ43GO2xJK2CNFy+5
 tXxj2QtHYxNySxJnAnHkOf33WJ/9+Ly/Xoqelq/6dxfQwcsXbK/zsGS5D Q==;
X-IronPort-AV: E=Sophos;i="5.91,244,1647273600"; d="scan'208";a="201933445"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 May 2022 06:22:41 +0800
IronPort-SDR: nbRvHdQA0rQU9Z3Rnu36RGoLKdIBDtgIxo49lTWb9WvcRUk8L54c3EOk+em2S9Q3X/TiUWboSB
 2AUwTA4OfXSPMw8b0IdIBGQrOmzj6n5h8HRvOIPDXS43LGYQes6D6RHJy0gCLqvpLxQwRRcK1i
 Uf+tI9hqOy1Xi2dsO5B35kGHGXURlRErRcTcbmNNgQRlQCbvCjIppu0qDAp6YJ4vaby2MpXAtu
 Xm88Q12cpcVUF6aM1aLz2oD6nx/omXu705PRBhuUGnLBUFjbBREJ7PRXd0i2mcSmciBO0pcIVk
 60Vllk2J2uSRRGpJxMCTIoDS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 May 2022 14:42:15 -0700
IronPort-SDR: c/XOL6PpFwukI2IEQS+EMT1vCMXE/OMrVSWVMWYV6CgMehTQTlneGjwpkenpJHD6yWlnGs5i2i
 a/eafxPm6ZG6x59JrB2Ai51jdUeGBfMkqPCLJIyM5IPY0MtL/lX6xj2fy+W0O2l9pqhiZW+hW9
 SoEngZfhZDA6Cm1nHNaAuelshjaC0fH+YugnVGco4makhLgJeLOBGnipvdl2ulihU5Nmwaffmq
 dg2yCMx4Aejz8pH4fPbnbNdugROPijacs/wA6RbqlbG1FyojxLrC1DL5I9Nm+NZOdd+EC15K/U
 njE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 May 2022 15:22:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L5w2815Ckz1Rvlx
 for <iommu@lists.linux-foundation.org>; Sun, 22 May 2022 15:22:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1653258159; x=1655850160; bh=g7+JeN4wnrl6dFXGk3nhuKNxU3bxTCBHH+i
 qteHxNFE=; b=cFP8EjCWYzIn0k4ie3WKPohm2MCo0AumuYqBQTKCtVbOnF5ahgC
 3DMD77wHEBGNIby9QYVO8Kyj8ThYO13/AhkkmwvMo1hw6M+usps0UivIXgCdZseU
 9A6F5n+Fh6VrhIr7wexiIbbqwP/tasyeStlJ/r5Q78CNt8JpJvfsexJ4TyKQTbY2
 aY7WAwIjYDT4mh9L4oSbx4j06Oa3+BPww0WpgkiA5gn05hxU90tfn4OZw+TdYdiC
 O82vY1I2LjR+sEaV1nVlyE1A1wP+OTnEVYJ/WTGpbJJtbREAsy8XMVCmYRSC0I1S
 oStpPqSyJ5iYY82wZ98GYO9okFFzZCtC3dw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id iFoughfYD3yB for <iommu@lists.linux-foundation.org>;
 Sun, 22 May 2022 15:22:39 -0700 (PDT)
Received: from [10.89.85.73] (c02drav6md6t.dhcp.fujisawa.hgst.com
 [10.89.85.73])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L5w252KbGz1Rvlc;
 Sun, 22 May 2022 15:22:37 -0700 (PDT)
Message-ID: <15f94ea2-fa97-3122-60dd-a87a3dd8a7db@opensource.wdc.com>
Date: Mon, 23 May 2022 07:22:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 0/4] DMA mapping changes for SCSI core
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <20220522131345.GB25785@lst.de>
Organization: Western Digital Research
In-Reply-To: <20220522131345.GB25785@lst.de>
Cc: linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
 linux-doc@vger.kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
 liyihang6@hisilicon.com, robin.murphy@arm.com, jejb@linux.ibm.com
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
From: Damien Le Moal via iommu <iommu@lists.linux-foundation.org>
Reply-To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/05/22 22:13, Christoph Hellwig wrote:
> The whole series looks fine to me.  I'll happily queue it up in the
> dma-mapping tree if the SCSI and ATA maintainers are ok with that.
> 

Fine with me. I sent an acked-by for the libata bit.

-- 
Damien Le Moal
Western Digital Research
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
