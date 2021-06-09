Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64774C47095
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 07:49:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D3D6135D
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 07:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D3D6135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCBEB40275;
	Wed,  9 Jun 2021 07:49:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VsKjWb1Za_K7; Wed,  9 Jun 2021 07:49:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 89D0C4025B;
	Wed,  9 Jun 2021 07:49:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C8C0C000E;
	Wed,  9 Jun 2021 07:49:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54583C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 07:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F5AB401B6
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 07:49:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id psuBRmAIYbR7 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 07:49:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9229D400D4
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 07:49:00 +0000 (UTC)
IronPort-SDR: bLVB9ByhFagImxHatyKRu4b1Gfu5wlqKi8Dkb7ouRM2dNP5yI6Gws9b+oda6zWU8V9u2DSNZVm
 /F+HLW6NBIIg==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="226390018"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; d="scan'208";a="226390018"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 00:48:59 -0700
IronPort-SDR: PFd3i6KK743/tq3npJaexSx+N7YLLYHWZzbadclXJ5v6GicPi5RIYi/rz1d7xzFEttD3PYqYP6
 sJJsVtHQZ2SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; d="scan'208";a="552591618"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105])
 ([10.239.159.105])
 by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2021 00:48:54 -0700
Subject: Re: [PATCH] iommu/vt-d: Dump DMAR translation structure
To: Kyung Min Park <kyung.min.park@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210526233549.31569-1-kyung.min.park@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <13351083-2929-046b-0538-4f760ee89571@linux.intel.com>
Date: Wed, 9 Jun 2021 15:47:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526233549.31569-1-kyung.min.park@intel.com>
Content-Language: en-US
Cc: ravi.v.shankar@intel.com, ashok.raj@intel.com, dwmw2@infradead.org,
 will@kernel.org
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

On 5/27/21 7:35 AM, Kyung Min Park wrote:
> When the dmar translation fault happens, the kernel prints a single line
> fault reason with corresponding hexadecimal code defined in the Intel VT-d
> specification.
> 
> Currently, when user wants to debug the translation fault in detail,
> debugfs is used for dumping the dmar_translation_struct, which is not
> available when the kernel failed to boot.
> 
> Dump the DMAR translation structure, pagewalk the IO page table and print
> the page table entry when the fault happens.
> 
> Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>

Please fix below compile error:

ld: drivers/iommu/intel/dmar.o: in function `dmar_fault_do_one':
/home/allen/Workspace/iommu/drivers/iommu/intel/dmar.c:1965: undefined 
reference to `dmar_fault_dump_ptes'
make: *** [Makefile:1191: vmlinux] Error 1

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
