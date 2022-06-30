Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED29C43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 02:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1ED79402D2;
	Thu, 30 Jun 2022 02:43:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1ED79402D2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EUtwdT3o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iRKlCNr5v4KM; Thu, 30 Jun 2022 02:43:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 93A3D402C2;
	Thu, 30 Jun 2022 02:43:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93A3D402C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61AB5C002D;
	Thu, 30 Jun 2022 02:43:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FC75C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 02:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0BE06402BA
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 02:43:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BE06402BA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ygRYSS3JtAZ for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 02:43:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D30A640224
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D30A640224
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 02:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656556984; x=1688092984;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1lniFQHbdKUYo5fK6cZ0TOr+5OfkEYvxDzpS35OnvAA=;
 b=EUtwdT3oscVGsyGLR6JhQogijiHUpbi4B3p83AVVtHy5WM0+2AybEHqW
 p0Ra7bqqvPTueNzStHDos89qDZRhilpgmK7iqrYZ25CEiJyf/HzVeRS0k
 DIfVl/mBrXOKDz3ySpwPmVrgJuoc8bXkTNiPbCMbDarcktQ6yVvJKogif
 Z8YuEaOnDmVwj9Gwz3RfyPoksZAi5pVQFgGYhq9FZ1IuqRTRSn9if0DCM
 rePKlq5ln98pc2KgCeEmu8O/CHSasfrOINWA4iD7ioov0dlKbJ1AQ6WMR
 sIWTShmE016qwTHRLp7w0ho5o1RBdL2YgodSnoCRAej9BsFCVUVwuCuHk Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="343909583"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; d="scan'208";a="343909583"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2022 19:43:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; d="scan'208";a="647681038"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.23])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2022 19:42:59 -0700
Date: Thu, 30 Jun 2022 10:42:43 +0800
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] swiotlb: Split up single swiotlb lock
Message-ID: <20220630024238.GA884@gao-cwp>
References: <20220628070136.419163-1-chao.gao@intel.com>
 <20220628070136.419163-4-chao.gao@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220628070136.419163-4-chao.gao@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: len.brown@intel.com, tony.luck@intel.com, Kees Cook <keescook@chromium.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, rafael.j.wysocki@intel.com,
 dave.hansen@intel.com, iommu@lists.linux-foundation.org,
 Andi Kleen <ak@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Borislav Petkov <bp@suse.de>, Muchun Song <songmuchun@bytedance.com>,
 linux-pm@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 dan.j.williams@intel.com, reinette.chatre@intel.com,
 Andrew Morton <akpm@linux-foundation.org>, kirill.shutemov@linux.intel.com
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

On Tue, Jun 28, 2022 at 03:01:34PM +0800, Chao Gao wrote:
>From: Andi Kleen <ak@linux.intel.com>
>
>Traditionally swiotlb was not performance critical because it was only
>used for slow devices. But in some setups, like TDX confidential
>guests, all IO has to go through swiotlb. Currently swiotlb only has a
>single lock. Under high IO load with multiple CPUs this can lead to
>signifiant lock contention on the swiotlb lock. We've seen 20+% CPU
>time in locks in some extreme cases.
>
>This patch splits the swiotlb into individual areas which have their
>own lock. Each CPU tries to allocate in its own area first. Only if
>that fails does it search other areas. On freeing the allocation is
>freed into the area where the memory was originally allocated from.
>
>To avoid doing a full modulo in the main path the number of swiotlb
>areas is always rounded to the next power of two. I believe that's
>not really needed anymore on modern CPUs (which have fast enough
>dividers), but still a good idea on older parts.
>
>The number of areas can be set using the swiotlb option. But to avoid
>every user having to set this option set the default to the number of
>available CPUs. Unfortunately on x86 swiotlb is initialized before
>num_possible_cpus() is available, that is why it uses a custom hook
>called from the early ACPI code.
>
>Signed-off-by: Andi Kleen <ak@linux.intel.com>
>[ rebase and fix warnings of checkpatch.pl ]
>Signed-off-by: Chao Gao <chao.gao@intel.com>

Just noticed that Tianyu already posted a variant of this patch.
Will drop this one from my series.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
