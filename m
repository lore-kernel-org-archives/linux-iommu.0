Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB0DC433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 15:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDEB7606F5;
	Mon, 25 Apr 2022 15:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KntM6wASn-Hy; Mon, 25 Apr 2022 15:31:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 977D960E16;
	Mon, 25 Apr 2022 15:31:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 558B7C0039;
	Mon, 25 Apr 2022 15:31:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5CA5C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 15:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0BF2414E7
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 15:31:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vJBI5xTq5A-j for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 15:31:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C5BE414C9
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650900670; x=1682436670;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QmBvHFEL8jCRZp/04JCJNkoj3kFPY6FDP8vzsw7y6UI=;
 b=f4cwozHchWhQskb98gzd3x8RejN4veQ4HCmlRatmdoKUw4AHGHS9rlNY
 FU/KO6IfNTyyNMagLe8EV2/ecY0ggv+mzbjb3iuc0AmERDremdi6afLGf
 MpxqjQTCZ2F2HDfpPmW7sE98ypvwGUHiAHVnF4chnxliYes1Qi2DfNcpv
 qjXpcuJ8rhJIL+ZQvd242hwSSkTdAKofyTEzaH1qp9Kd6JI1ierINVSxy
 oHY0Ry7Phm+ydEXsjk6zQgGqx4I64C8b3SH/YyRattFJSvdZyQoLeE9WT
 WwTPW85BiRsE3QeXRq045K+tim5cYO1yfrj4UgsgXiV36SRqDW9NsaumN w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265445386"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; d="scan'208";a="265445386"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2022 08:31:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; d="scan'208";a="579340231"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2022 08:31:06 -0700
Date: Mon, 25 Apr 2022 08:34:44 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <20220425083444.00af5674@jacob-builder>
In-Reply-To: <YmavoKkVu+hd+x0M@myrica>
References: <YllADL6uMoLllzQo@fyu1.sc.intel.com> <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 zhangfei.gao@linaro.org, Thomas Gleixner <tglx@linutronix.de>,
 robin.murphy@arm.com
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

Hi Jean-Philippe,

On Mon, 25 Apr 2022 15:26:40 +0100, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Mon, Apr 25, 2022 at 07:18:36AM -0700, Dave Hansen wrote:
> > On 4/25/22 06:53, Jean-Philippe Brucker wrote:  
> > > On Sat, Apr 23, 2022 at 07:13:39PM +0800, zhangfei.gao@foxmail.com
> > > wrote:  
> > >>>> On 5.17
> > >>>> fops_release is called automatically, as well as
> > >>>> iommu_sva_unbind_device. On 5.18-rc1.
> > >>>> fops_release is not called, have to manually call close(fd)  
> > >>> Right that's weird  
> > >> Looks it is caused by the fix patch, via mmget, which may add
> > >> refcount of fd.  
> > > Yes indirectly I think: when the process mmaps the queue,
> > > mmap_region() takes a reference to the uacce fd. That reference is
> > > released either by explicit close() or munmap(), or by exit_mmap()
> > > (which is triggered by mmput()). Since there is an mm->fd dependency,
> > > we cannot add a fd->mm dependency, so no mmget()/mmput() in
> > > bind()/unbind().
> > > 
> > > I guess we should go back to refcounted PASIDs instead, to avoid
> > > freeing them until unbind().  
> > 
> > Yeah, this is a bit gnarly for -rc4.  Let's just make sure there's
> > nothing else simple we can do.
> > 
> > How does the IOMMU hardware know that all activity to a given PASID is
> > finished?  That activity should, today, be independent of an mm or a
> > fd's lifetime.  
> 
> In the case of uacce, it's tied to the fd lifetime: opening an accelerator
> queue calls iommu_sva_bind_device(), which sets up the PASID context in
> the IOMMU. Closing the queue calls iommu_sva_unbind_device() which
> destroys the PASID context (after the device driver stopped all DMA for
> this PASID).
> 
For VT-d, it is essentially the same flow except managed by the individual
drivers such as DSA.
If free() happens before unbind(), we deactivate the PASIDs and suppress
faults from the device. When the unbind finally comes, we finalize the
PASID teardown. It seems we have a need for an intermediate state where
PASID is "pending free"?

> Thanks,
> Jean
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
