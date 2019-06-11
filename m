Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718AAC43218
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 15:14:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548E42080A
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 15:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548E42080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 44843F22;
	Tue, 11 Jun 2019 15:14:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8B7ABF1F
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 15:13:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1AD8B174
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 15:13:58 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60FFB307D984;
	Tue, 11 Jun 2019 15:13:51 +0000 (UTC)
Received: from x1.home (ovpn-116-190.phx2.redhat.com [10.3.116.190])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E3E660C4C;
	Tue, 11 Jun 2019 15:13:48 +0000 (UTC)
Date: Tue, 11 Jun 2019 09:13:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jiangyiwen <jiangyiwen@huawei.com>
Subject: Re: [bug report] vfio: Can't find phys by iova in vfio_unmap_unpin()
Message-ID: <20190611091348.60195fe0@x1.home>
In-Reply-To: <5CFFA149.8070303@huawei.com>
References: <5CE25C33.2060009@huawei.com> <20190520132801.4e2ab8ab@x1.home>
	<5CFF1E35.5010602@huawei.com> <5CFFA149.8070303@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 11 Jun 2019 15:13:57 +0000 (UTC)
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
	kvm@vger.kernel.org
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

[cc +iommu]

On Tue, 11 Jun 2019 20:40:41 +0800
Jiangyiwen <jiangyiwen@huawei.com> wrote:

> Hi Alex,
> 
> I found this problem is not very easy to solve, for
> now, in arm64 platform, the "0" physical address
> is a valid system memory address, so in function
> arm_smmu_iova_to_phys() I think it should not use
> "0" as abnormal return value.
> 
> Do you have any idea?

I think you're going to need to redefine iommu_iova_to_phys() and fix
all the IOMMU implementations of it to comply.  Currently AMD and Intel
IOMMU driver return zero if a mapping is not found.  You could make the
function return 0/errno and return the physical address via a pointer
arg.  You could also keep the existing definition, but introduce a test
for a valid result that might use an architecture specific value (akin
to IS_ERR()).  You could also just reserve the zero page from userspace
allocation.  I really don't want #ifdef in the vfio iommu driver trying
to discern the correct invalid value though.  Thanks,

Alex

> On 2019/6/11 11:21, jiangyiwen wrote:
> > On 2019/5/21 3:28, Alex Williamson wrote:  
> >> On Mon, 20 May 2019 15:50:11 +0800
> >> jiangyiwen <jiangyiwen@huawei.com> wrote:
> >>  
> >>> Hello alex,
> >>>
> >>> We test a call trace as follows use ARM64 architecture,
> >>> it prints a WARN_ON() when find not physical address by
> >>> iova in vfio_unmap_unpin(), I can't find the cause of
> >>> problem now, do you have any ideas?  
> >> Is it reproducible?  Can you explain how to reproduce it?  The stack
> >> trace indicates a KVM VM is being shutdown and we're trying to clean
> >> out the IOMMU mappings from the domain and find a page that we think
> >> should be mapped that the IOMMU doesn't have mapped.  What device(s) was
> >> assigned to the VM?  This could be an IOMMU driver bug or a
> >> vfio_iommu_type1 bug.  Have you been able to reproduce this on other
> >> platforms?
> >>  
> > Hello Alex,
> >
> > Sorry to reply you so late because of some things,
> > this problem's reason is in some platform (like ARM64),
> > the "0" physical address is valid and can be used for
> > system memory, so in this case it should not print a
> > WARN_ON() and continue, we should unmap and unpin this
> > "0" physical address in these platform.
> >
> > So I want to return FFFFFFFFFFFFFFFFL instead of "0" as invalid
> > physical address in function iommu_iova_to_phys(). Do you think
> > it's appropriate?
> >
> > Thanks,
> > Yiwen.
> >  
> >>> In addition, I want to know why there is a WARN_ON() instead
> >>> of BUG_ON()? Does it affect the follow-up process?  
> >> We're removing an IOMMU page mapping entry and find that it's not
> >> present, so ultimately the effect at the IOMMU is the same, there's no
> >> mapping at that address, but I can't say without further analysis
> >> whether that means a page remains pinned or if that inconsistency was
> >> resolved previously elsewhere.  We WARN_ON because this is not what we
> >> expect, but potentially leaking a page of memory doesn't seem worthy of
> >> crashing the host, nor would a crash dump at that point necessarily aid
> >> in resolving the missing page as it potentially occurred well in the
> >> past.  Thanks,
> >>
> >> Alex
> >>
> >> .
> >>  
> >
> >
> > .
> >  
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
