Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A412FC17441
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 15:06:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF312084F
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 15:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF312084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 63404CD5;
	Mon, 11 Nov 2019 15:06:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AD524CBF
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 15:06:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 460348D9
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 15:06:40 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 872C61E6; Mon, 11 Nov 2019 16:06:32 +0100 (CET)
Date: Mon, 11 Nov 2019 16:06:31 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Yian Chen <yian.chen@intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: Check VT-d RMRR region in BIOS is
	reported as reserved
Message-ID: <20191111150630.GF18333@8bytes.org>
References: <20191017113919.25424-1-yian.chen@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191017113919.25424-1-yian.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ravi Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
	linux-ia64@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, Oct 17, 2019 at 04:39:19AM -0700, Yian Chen wrote:
> VT-d RMRR (Reserved Memory Region Reporting) regions are reserved
> for device use only and should not be part of allocable memory pool of OS.
> 
> BIOS e820_table reports complete memory map to OS, including OS usable
> memory ranges and BIOS reserved memory ranges etc.
> 
> x86 BIOS may not be trusted to include RMRR regions as reserved type
> of memory in its e820 memory map, hence validate every RMRR entry
> with the e820 memory map to make sure the RMRR regions will not be
> used by OS for any other purposes.
> 
> ia64 EFI is working fine so implement RMRR validation as a dummy function
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> ---
> v2:
> - return -EINVAL instead of -EFAULT when there is an error
> ---
>  arch/ia64/include/asm/iommu.h |  5 +++++
>  arch/x86/include/asm/iommu.h  | 18 ++++++++++++++++++
>  drivers/iommu/intel-iommu.c   |  8 +++++++-
>  3 files changed, 30 insertions(+), 1 deletion(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
