Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEF0C43334
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 20:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE8C041C32;
	Thu,  9 Jun 2022 20:34:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5nxHSpIBncsb; Thu,  9 Jun 2022 20:34:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6CA3641B6B;
	Thu,  9 Jun 2022 20:34:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42265C0039;
	Thu,  9 Jun 2022 20:34:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F493C002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 20:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3812260601
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 20:34:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D0TdxgAuOzDi for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 20:34:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B1358605AC
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 20:34:35 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id a10so22320831pju.3
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jun 2022 13:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=6wtdNtGFdpESF6glfweoRrpOjBH9aO2zp0t1kc4rzd4=;
 b=0dgrXBLDaXfFsYySpZo1gsbD0xOoIKkjkXHZngb1wIvViv2Reik/E97UBPb0ITQGZx
 zbnd64AEVeSv8FWLuM4W66hfprgMdMd1ruLn3aWiLNS4MeduXthb+qLmsaFMrQZfCuFb
 ugdyd7K6YJTCqvLvSq5qU1ZHCH/PSO3eprbLTXsAfYYZ7wWnvjUuMsiI1bs04GhI8B8Q
 N7fOah/QFuzMzjQKN4S2QcwqC9F2wxB4Tz0Af8Z6h1HWU2ptF9NX1VCjKGho2RpvlYv2
 GigqP7J71/VK1yL32fDB46/9RnZtrjMeYMBMxHmNyuea0c9VMBKfbdT1GPPKy13IhgJn
 Thgg==
X-Gm-Message-State: AOAM532qHxiiQg4aQuz7U/8F9j6feorCH9jGenhu/mSPmbPwOSTiaSld
 gtbO4J86NnMhL8OYrMuiW9s=
X-Google-Smtp-Source: ABdhPJzP68mcRSDMkhmkAefbn0A7+sB9Xcl1QQgOF53xsaTu2y4djDDrLLteVYsPMpjj5mZsq2HCYQ==
X-Received: by 2002:a17:903:22d1:b0:166:4bc1:a1da with SMTP id
 y17-20020a17090322d100b001664bc1a1damr37186025plg.13.1654806874934; 
 Thu, 09 Jun 2022 13:34:34 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8a44:a3e:c994:3f4b?
 ([2620:15c:211:201:8a44:a3e:c994:3f4b])
 by smtp.gmail.com with ESMTPSA id
 k16-20020aa79d10000000b0050dc7628162sm17863699pfp.60.2022.06.09.13.34.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jun 2022 13:34:33 -0700 (PDT)
Message-ID: <23bf4427-41c3-bf1d-903a-75928bb47627@acm.org>
Date: Thu, 9 Jun 2022 13:34:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, damien.lemoal@opensource.wdc.com,
 joro@8bytes.org, will@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-4-git-send-email-john.garry@huawei.com>
 <fe365aa8-00d5-153d-ceb2-f887a71a6927@acm.org>
 <31417477-953d-283e-808e-cf8701e820a8@huawei.com>
 <bccbcc9b-4750-a1a7-130f-69eeea5dcb23@acm.org>
 <5b214e95-dd95-551a-496e-a2139a74e8eb@huawei.com>
 <a2585983-75d7-c627-13ba-38a464cf716e@acm.org>
 <9b1d155e-28cc-08dc-5a5a-8580132575e7@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9b1d155e-28cc-08dc-5a5a-8580132575e7@huawei.com>
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
 liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 6/9/22 10:54, John Garry wrote:
> ok, but do you have a system where the UFS host controller is behind an 
> IOMMU? I had the impression that UFS controllers would be mostly found 
> in embedded systems and IOMMUs are not as common on there.

Modern phones have an IOMMU. Below one can find an example from a Pixel 
6 phone. The UFS storage controller is not controller by the IOMMU as 
far as I can see but I wouldn't be surprised if the security team would 
ask us one day to enable the IOMMU for the UFS controller.

# (cd /sys/class/iommu && ls */devices)
1a090000.sysmmu/devices:
19000000.aoc

1a510000.sysmmu/devices:
1a440000.lwis_csi

1a540000.sysmmu/devices:
1aa40000.lwis_pdp

1a880000.sysmmu/devices:
1a840000.lwis_g3aa

1ad00000.sysmmu/devices:
1ac40000.lwis_ipp  1ac80000.lwis_gtnr_align

1b080000.sysmmu/devices:
1b450000.lwis_itp

1b780000.sysmmu/devices:

1b7b0000.sysmmu/devices:
1b760000.lwis_mcsc

1b7e0000.sysmmu/devices:

1baa0000.sysmmu/devices:
1a4e0000.lwis_votf  1ba40000.lwis_gdc

1bad0000.sysmmu/devices:
1ba60000.lwis_gdc

1bb00000.sysmmu/devices:
1ba80000.lwis_scsc

1bc70000.sysmmu/devices:
1bc40000.lwis_gtnr_merge

1bca0000.sysmmu/devices:

1bcd0000.sysmmu/devices:

1bd00000.sysmmu/devices:

1bd30000.sysmmu/devices:

1c100000.sysmmu/devices:
1c300000.drmdecon  1c302000.drmdecon

1c110000.sysmmu/devices:

1c120000.sysmmu/devices:

1c660000.sysmmu/devices:
1c640000.g2d

1c690000.sysmmu/devices:

1c710000.sysmmu/devices:
1c700000.smfc

1c870000.sysmmu/devices:
1c8d0000.MFC-0  mfc

1c8a0000.sysmmu/devices:

1ca40000.sysmmu/devices:
1cb00000.bigocean

1cc40000.sysmmu/devices:
1ce00000.abrolhos

Bart.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
