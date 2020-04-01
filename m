Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3580EC2D0F0
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 14:03:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045FD2078B
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 14:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJVoxwSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045FD2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CAB2E86E55;
	Wed,  1 Apr 2020 14:03:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eeuCwhmJ4zvK; Wed,  1 Apr 2020 14:03:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9693986E4E;
	Wed,  1 Apr 2020 14:03:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84C04C1D7F;
	Wed,  1 Apr 2020 14:03:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04445C089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 14:03:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E807486E4E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 14:03:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Q-d7HpbhsUf for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 14:03:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9C8E286DFF
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 14:03:11 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id t8so3348586wmi.2
 for <iommu@lists.linux-foundation.org>; Wed, 01 Apr 2020 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BZh/ep1PwflYg/TcVbQWbI9WFDXF6Zf/SxB/stv9Mls=;
 b=iJVoxwSIw2BIZ9rBNHiu4pE8g1NRc7+PSPp8la7NhJdpFxjHDKyGinpPbVA1bDBaLy
 JWfME5yxhkc0t37BG7HoUNLT70weCKWmItcDq5pcwKANEh1mfSNCHu+WNxUOuM90Evj3
 ZLzyrwwdewYiP+Z/VKq5UJvhZ29tuA1NFNz/n2e8pAk+s3dnA12Ql+oP4EJ71n2k5wJZ
 TO18IJqyFdcr9oOGeS/goHgQt2Bn0WgayCd4kyqLcx1v+uoPQpObXXJ5HS1ugxgEcox4
 7LWh57pxFDBkrYWVopK6w27ruQetrT4T7a1RAyR6Ast04V8tGXwqOp0ISbts6Riw+0hy
 zgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BZh/ep1PwflYg/TcVbQWbI9WFDXF6Zf/SxB/stv9Mls=;
 b=L0lQqo/lPyrTQxGQaFqrkeEZaRU1H8xFIrY7YFLCS0Whr8ijDGzctGk3f4vtP6BSNL
 fgz8EssWyuzlMZNq84BxVL4aMkXUW84HJHKGib6MeGlcimACGn1Q24Lxi8V61fqhNA4v
 HWop1KxfS9k+rzt4PG1jrEapPeGXHiB1GfRcYTvfChxVRwp9u1oxoudXSvqWmtRoJeq9
 MhsnVjvT/MSibn0qrPwxQdvpKwv1S7z5mh3FB3liMekY0swq4WWRolADx//X/GmXkOBP
 DvEQJ91K4AWrf9+6j60YnkrLt6Lhq0FAiHyauMbdjcuL2CvWttj+yW60nzjWwb429q+l
 8ENg==
X-Gm-Message-State: AGi0Pua9+7MjTJhYg7Viuo6x71Ef6PirrHu9glzgkX7PscwHV1FRkCNP
 gK2hP/sWSfQAWa8bQtGRYx0uHA==
X-Google-Smtp-Source: APiQypK9DSjnsSakIQglnIUiMrqd7eWrNRxGsgEAIFwatDbnZWJ4FFPhmKQLr32+hb+lvqulo78TJg==
X-Received: by 2002:a1c:7216:: with SMTP id n22mr4371537wmc.41.1585749789988; 
 Wed, 01 Apr 2020 07:03:09 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
 by smtp.gmail.com with ESMTPSA id 71sm3267508wrc.53.2020.04.01.07.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 07:03:09 -0700 (PDT)
Date: Wed, 1 Apr 2020 16:03:01 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 00/10] IOASID extensions for guest SVA
Message-ID: <20200401140301.GJ882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

Hi Jacob,

On Wed, Mar 25, 2020 at 10:55:21AM -0700, Jacob Pan wrote:
> IOASID was introduced in v5.5 as a generic kernel allocator service for
> both PCIe Process Address Space ID (PASID) and ARM SMMU's Sub Stream
> ID. In addition to basic ID allocation, ioasid_set was introduced as a
> token that is shared by a group of IOASIDs. This set token can be used
> for permission checking but lack of some features needed by guest Shared
> Virtual Address (SVA). In addition, IOASID support for life cycle
> management is needed among multiple users.
> 
> This patchset introduces two extensions to the IOASID code,
> 1. IOASID set operations
> 2. Notifications for IOASID state synchronization

My main concern with this series is patch 7 changing the spinlock to a
mutex, which prevents SVA from calling ioasid_free() from the RCU callback
of MMU notifiers. Could we use atomic notifiers, or do the FREE
notification another way?

Most of my other comments are just confusion on my part, I think, as I
haven't yet properly looked through the VFIO and VT-d changes. I'd rather
avoid the change to ioasid_find() if possible, because it adds a seemingly
unnecessary indirection to the fast path, but it's probably insignificant.

Thanks,
Jean

> 
> Part #1:
> IOASIDs used by each VM fits naturally into an ioasid_set. The usage
> for per set management requires the following features:
> 
> - Quota enforcement - This is to prevent one VM from abusing the
>   allocator to take all the system IOASIDs. Though VFIO layer can also
>   enforce the quota, but it cannot cover the usage with both guest and
>   host SVA on the same system.
> 
> - Stores guest IOASID-Host IOASID mapping within the set. To
>   support live migration, IOASID namespace should be owned by the
>   guest. This requires per IOASID set look up between guest and host
>   IOASIDs. This patchset does not introduce non-identity guest-host
>   IOASID lookup, we merely introduce the infrastructure in per set data.
> 
> - Set level operations, e.g. when a guest terminates, it is likely to
> free the entire set. Having a single place to manage the set where the
> IOASIDs are stored makes iteration much easier.
> 
> 
> New APIs are:
> - void ioasid_install_capacity(ioasid_t total);
>   Set the system capacity prior to any allocations. On x86, VT-d driver
>   calls this function to set max number of PASIDs, typically 1 million
>   (20 bits).
> 
> - int ioasid_alloc_system_set(int quota);
>   Host system has a default ioasid_set, during boot it is expected that
>   this default set is allocated with a reasonable quota, e.g. PID_MAX.
>   This default/system set is used for baremetal SVA.
> 
> - int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int
> *sid);
>   Allocate a new set with a token, returned sid (set ID) will be used
>   to allocate IOASIDs within the set. Allocation of IOASIDs cannot
>   exceed the quota.
> 
> - void ioasid_free_set(int sid, bool destroy_set);
>   Free the entire set and notify all users with an option to destroy
>   the set. Set ID can be used for allocation again if not destroyed.
> 
> - int ioasid_find_sid(ioasid_t ioasid);
>   Look up the set ID from an ioasid. There is no reference held,
>   assuming set has a single owner.
> 
> - int ioasid_adjust_set(int sid, int quota);
>   Change the quota of the set, new quota cannot be less than the number
>   of IOASIDs already allocated within the set. This is useful when
>   IOASID resource needs to be balanced among VMs.
> 
> Part #2
> Notification service. Since IOASIDs are used by many consumers that
> follow publisher-subscriber pattern, notification is a natural choice
> to keep states synchronized. For example, on x86 system, guest PASID
> allocation and bind call results in VFIO IOCTL that can add and change
> guest-host PASID states. At the same time, IOMMU driver and KVM need to
> maintain its own PASID contexts. In this case, VFIO is the publisher
> within the kernel, IOMMU driver and KVM are the subscribers.
> 
> This patchset introduces a global blocking notifier chain and APIs to
> operate on. Not all events nor all IOASIDs are of interests to all
> subscribers. e.g. KVM is only interested in the IOASIDs within its set.
> IOMMU driver is not ioasid_set aware. A further optimization could be
> having both global and per set notifier. But consider the infrequent
> nature of bind/unbind and relatively long process life cycle, this
> optimization may not be needed at this time.
> 
> To register/unregister notification blocks, use these two APIs:
> - int ioasid_add_notifier(struct notifier_block *nb);
> - void ioasid_remove_notifier(struct notifier_block *nb)
> 
> To send notification on an IOASID with one of the commands (FREE,
> BIND/UNBIND, etc.), use:
> - int ioasid_notify(ioasid_t id, enum ioasid_notify_val cmd);
> 
> This work is a result of collaboration with many people:
> Liu, Yi L <yi.l.liu@intel.com>
> Wu Hao <hao.wu@intel.com>
> Ashok Raj <ashok.raj@intel.com>
> Kevin Tian <kevin.tian@intel.com>
> 
> Thanks,
> 
> Jacob
> 
> Jacob Pan (10):
>   iommu/ioasid: Introduce system-wide capacity
>   iommu/vt-d: Set IOASID capacity when SVM is enabled
>   iommu/ioasid: Introduce per set allocation APIs
>   iommu/ioasid: Rename ioasid_set_data to avoid confusion with
>     ioasid_set
>   iommu/ioasid: Create an IOASID set for host SVA use
>   iommu/ioasid: Convert to set aware allocations
>   iommu/ioasid: Use mutex instead of spinlock
>   iommu/ioasid: Introduce notifier APIs
>   iommu/ioasid: Support ioasid_set quota adjustment
>   iommu/vt-d: Register PASID notifier for status change
> 
>  drivers/iommu/intel-iommu.c |  20 ++-
>  drivers/iommu/intel-svm.c   |  89 ++++++++--
>  drivers/iommu/ioasid.c      | 387 +++++++++++++++++++++++++++++++++++++++-----
>  include/linux/intel-iommu.h |   1 +
>  include/linux/ioasid.h      |  86 +++++++++-
>  5 files changed, 522 insertions(+), 61 deletions(-)
> 
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
