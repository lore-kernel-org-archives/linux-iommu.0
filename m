Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1024DC433EF
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 14:00:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB52461B6F
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 14:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB52461B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57A1560645;
	Wed, 17 Nov 2021 14:00:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vX2qxU_ubTrU; Wed, 17 Nov 2021 14:00:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 14CEF60631;
	Wed, 17 Nov 2021 14:00:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9533C002E;
	Wed, 17 Nov 2021 14:00:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F12ACC0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 14:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA42180CFB
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 14:00:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5dVh1fcSU_Wj for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 14:00:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 304FE80D07
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 14:00:20 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id u11so2253953plf.3
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 06:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=pfKT7vWJtxV2smk9CnW5qMlXjmk0IHKeJrqLf4YFRis=;
 b=Rjj9c6AtN53lwjrZL6EQMTK4S9B6EyjLDiTKAEZtG92IG/z5eW4MmmZjuNMEaPPtjf
 LSOJT/vIwEcxXU1K7Ca+hnK+LznG3PkqsB9P36idDXcWR6yBZ0TKu/gYYNIynsfa6uwl
 wwXh4cR3P9Fphh3Ru4IOABiaCcVVd3dR/Z+YDRN5tiFV3q6iF+hOXqmMcg2FfSxJRFzw
 2zMMFPxbuq+GlPyeaD3MgQIipxxSO7TRApycEHsiuMj7dn5MGNWFoo8smcQRSoTJRhJs
 ZsXAJgdRa8E0sMFr5/frJselNGMJAjuNu9fCWyvPs//KwOW3T6zPAQdpgf+k/6JRtRmA
 Pl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=pfKT7vWJtxV2smk9CnW5qMlXjmk0IHKeJrqLf4YFRis=;
 b=S0D5Hyx2pbFFE5MX//c31ocedqYM2pyTjchOtY13qS67MXGU747YqJAUoAVPSoI3Xh
 tvJFSZyqmKQ3W/DNB3O+PGXBLU67A5st4e3uRjHTJA+OMoT04s3f9NRn7Y4+jcYDnro/
 dz+qG57ynrW3b2wLhMbjXSzcJv4hxl+xseqhBqR3PA/KT38OQOWuKD/O0D4PvQV7WXJZ
 AC6VGiu4iqNORcxABaaijpuyhLHOBPXbpbCEIdkcxWVyv+ur8HwpfX9l638uRAa3Yi7u
 B1GWIKlgN6dAn28yTkCnaXvDSnh0ENdkQ87iFKUpc7TBQU64T3V4pfDRlDAmoxIqrGRT
 SfJA==
X-Gm-Message-State: AOAM530AVOBbB+Rd4WjD2QUevcm8ghkumH/5f8IIcrfes/w10SbBUbTY
 /cPTAZxcJq9y8ioUAuFV7p0=
X-Google-Smtp-Source: ABdhPJz045G1qOXv6u71zRNaxnc6W77FjMF/vz0ksg1+BccDMfhcBoN3nBp5JPhXQCiAcID15bfAZg==
X-Received: by 2002:a17:903:32c2:b0:141:eed4:ec1c with SMTP id
 i2-20020a17090332c200b00141eed4ec1cmr56123455plr.33.1637157619685; 
 Wed, 17 Nov 2021 06:00:19 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 95sm5490056pjo.2.2021.11.17.06.00.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Nov 2021 06:00:19 -0800 (PST)
Message-ID: <c93bf3d4-75c1-bc3d-2789-1d65e7c19158@gmail.com>
Date: Wed, 17 Nov 2021 22:00:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/5] hyperv/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20211116153923.196763-1-ltykernel@gmail.com>
 <20211116153923.196763-4-ltykernel@gmail.com> <20211117100142.GB10330@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20211117100142.GB10330@lst.de>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 linux-scsi@vger.kernel.org, x86@kernel.org, decui@microsoft.com,
 michael.h.kelley@microsoft.com, mingo@redhat.com, kuba@kernel.org,
 haiyangz@microsoft.com, parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 jejb@linux.ibm.com, bp@alien8.de, luto@kernel.org,
 xen-devel@lists.xenproject.org, tglx@linutronix.de, jgross@suse.com,
 martin.petersen@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com, davem@davemloft.net
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

On 11/17/2021 6:01 PM, Christoph Hellwig wrote:
> This doesn't really have much to do with normal DMA mapping,
> so why does this direct through the dma ops?
> 

According to the previous discussion, dma_alloc_noncontigous()
and dma_vmap_noncontiguous() may be used to handle the noncontigous
memory alloc/map in the netvsc driver. So add alloc/free and vmap/vunmap
callbacks here to handle the case. The previous patch v4 & v5 handles
the allocation and map in the netvsc driver. If this should not go 
though dma ops, We also may make it as vmbus specific function and keep
the function in the vmbus driver.

https://lkml.org/lkml/2021/9/28/51


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
