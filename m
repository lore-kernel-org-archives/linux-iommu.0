Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38808C43217
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 04:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D124F81382;
	Tue, 14 Dec 2021 04:37:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A9CfHlC78o7b; Tue, 14 Dec 2021 04:37:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BFEC481361;
	Tue, 14 Dec 2021 04:37:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7776C002F;
	Tue, 14 Dec 2021 04:37:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A82CC0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 04:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B080403C7
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 04:37:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aHTBC6-lGxjs for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 04:37:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AB4540274
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 04:37:07 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id v19so12712650plo.7
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 20:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:from:subject:to:cc
 :references:content-language:in-reply-to:content-transfer-encoding;
 bh=w4jF6pVlAr6sHba/AXtkTZyGmAkMDj6qQwAZlJ+UdLM=;
 b=OO8cW6CQyLhwtJRdZo64ynH6YeKqGhXzDwlR96DxhxE8Bz5kntawlo3U2eaGVD6CHI
 QwlLfqlppyoVymnRsSdhwAbcwoI1D7iwAn/eC7pS7Pj0K1VfQQPlhUUd5xy+WbCBAYDe
 CQOlcjQSfsQlxLiRuxOWyrkrVDXvfEueSrvOQHwoCOK3vTOpot3KDNKHU3PW7aUlZOQX
 MN7v7ONz+WWwWOXpsViMSrzGNo6sSDbOMGzJD6Qa0xvRGJgAgkSVClBY32rRHfyCo6A3
 FQ9HQBcHZRpZZlCrmfLicfdlKItAAolAJVEfIXHGJEJMbZjO/ZWcO9H4hEoGAYqHbkbf
 SDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:from
 :subject:to:cc:references:content-language:in-reply-to
 :content-transfer-encoding;
 bh=w4jF6pVlAr6sHba/AXtkTZyGmAkMDj6qQwAZlJ+UdLM=;
 b=dh/8pWuyF41awIxnPECy9vrS+DmBIQAf+JQh8Eq02/BegP2DX/McLXKFZkJ0ShVWBG
 mL1UFXPAfkz1ZXTHt8EbwzOJE7C5Os/u25n/nnN7yE6BzeacOcL2bYfWlrJjZ5IPryWF
 sjfQItpM5KX/cb03VkgVzR6u8lYpbA3Y1pBRJD7tN5XdiLKbPiKaDcs2/WKX2cNHfO2e
 lPxL40bsygSXXSYQSPifMTd3iTW3bN5zVCjdDqv2sspD7+y5O+t2lhmLp77cT6FzL8IC
 V1ZolMOVSuxfbSm1/fyI7BjRe5BO+O87AhulCKTctA+AT33haU/iMHtjWzvQezS3shdH
 wISA==
X-Gm-Message-State: AOAM5319lKnmYtfGq2bgnR6XZTBAQqLVvTcfxz+/yigr7vwD9RUvtylU
 lea/7SReQIG97/RaA1nNaBM=
X-Google-Smtp-Source: ABdhPJw8uDA1QXzEpygmuAAZVoXz6dprKQR+3bFuLs1n/mm4f5XuNE+IqFlivIE3110OJ/+FyvUzTA==
X-Received: by 2002:a17:90b:4b86:: with SMTP id
 lr6mr2944595pjb.98.1639456626921; 
 Mon, 13 Dec 2021 20:37:06 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 rm10sm812022pjb.29.2021.12.13.20.36.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Dec 2021 20:37:06 -0800 (PST)
Message-ID: <3243ff22-f6c8-b7cd-26b7-6e917e274a7c@gmail.com>
Date: Tue, 14 Dec 2021 12:36:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V7 1/5] swiotlb: Add swiotlb bounce buffer remap function
 for HV IVM
To: Dave Hansen <dave.hansen@intel.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, michael.h.kelley@microsoft.com
References: <20211213071407.314309-1-ltykernel@gmail.com>
 <20211213071407.314309-2-ltykernel@gmail.com>
 <198e9243-abca-b23e-0e8e-8581a7329ede@intel.com>
Content-Language: en-US
In-Reply-To: <198e9243-abca-b23e-0e8e-8581a7329ede@intel.com>
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, hch@lst.de
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

On 12/14/2021 12:45 AM, Dave Hansen wrote:
> On 12/12/21 11:14 PM, Tianyu Lan wrote:
>> In Isolation VM with AMD SEV, bounce buffer needs to be accessed via
>> extra address space which is above shared_gpa_boundary (E.G 39 bit
>> address line) reported by Hyper-V CPUID ISOLATION_CONFIG. The access
>> physical address will be original physical address + shared_gpa_boundary.
>> The shared_gpa_boundary in the AMD SEV SNP spec is called virtual top of
>> memory(vTOM). Memory addresses below vTOM are automatically treated as
>> private while memory above vTOM is treated as shared.
> 
> This seems to be independently reintroducing some of the SEV
> infrastructure.  Is it really OK that this doesn't interact at all with
> any existing SEV code?
> 
> For instance, do we need a new 'swiotlb_unencrypted_base', or should
> this just be using sme_me_mask somehow?

Hi Dave:
        Thanks for your review. Hyper-V provides a para-virtualized
confidential computing solution based on the AMD SEV function and not
expose sev&sme capabilities to guest. So sme_me_mask is unset in the
Hyper-V Isolation VM. swiotlb_unencrypted_base is more general solution
to handle such case of different address space for encrypted and
decrypted memory and other platform also may reuse it.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
