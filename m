Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92735C433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 08:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 341B08138E;
	Thu, 28 Apr 2022 08:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iR1VZ2u3up8n; Thu, 28 Apr 2022 08:17:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 596BE81388;
	Thu, 28 Apr 2022 08:17:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15C42C0081;
	Thu, 28 Apr 2022 08:17:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B407C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:17:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07A62408B6
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:17:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jrlWbZhRlNAL for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 08:17:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C51940301
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:17:02 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 01A4C2FB; Thu, 28 Apr 2022 10:16:59 +0200 (CEST)
Date: Thu, 28 Apr 2022 10:16:58 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Alex Deucher <alexander.deucher@amd.com>, corbet@lwn.net
Subject: Re: [PATCH] Documentation: x86: rework IOMMU documentation
Message-ID: <YmpNevdJFec0+9Mn@8bytes.org>
References: <20220422200607.627754-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220422200607.627754-1-alexander.deucher@amd.com>
Cc: dave.hansen@linux.intel.com, corbet@lwn.net, robin.murphy@arm.com,
 x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vasant.Hegde@amd.com, iommu@lists.linux-foundation.org, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, will@kernel.org
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

On Fri, Apr 22, 2022 at 04:06:07PM -0400, Alex Deucher wrote:
> Add preliminary documentation for AMD IOMMU and combine
> with the existing Intel IOMMU documentation and clean
> up and modernize some of the existing documentation to
> align with the current state of the kernel.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> 
> V2: Incorporate feedback from Robin to clarify IOMMU vs DMA engine (e.g.,
>     a device) and document proper DMA API.  Also correct the fact that
>     the AMD IOMMU is not limited to managing PCI devices.
> v3: Fix spelling and rework text as suggested by Vasant
> v4: Combine Intel and AMD documents into a single document as suggested
>     by Dave Hansen
> v5: Clarify that keywords are related to ACPI, grammatical fixes
> v6: Make more stuff common based on feedback from Robin
> 
>  Documentation/x86/index.rst       |   2 +-
>  Documentation/x86/intel-iommu.rst | 115 ------------------------
>  Documentation/x86/iommu.rst       | 143 ++++++++++++++++++++++++++++++
>  3 files changed, 144 insertions(+), 116 deletions(-)
>  delete mode 100644 Documentation/x86/intel-iommu.rst
>  create mode 100644 Documentation/x86/iommu.rst

Acked-by: Joerg Roedel <jroedel@suse.de>

Jonathan, will you merge that through the documentation tree?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
