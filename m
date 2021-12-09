Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B466EC4332F
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 06:32:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53AF2408FE;
	Thu,  9 Dec 2021 06:32:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vOZA1kzPzeso; Thu,  9 Dec 2021 06:32:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E30FF408F9;
	Thu,  9 Dec 2021 06:32:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5AC3C002F;
	Thu,  9 Dec 2021 06:32:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD99EC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 06:32:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A735E408FE
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 06:32:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rHz28ZKAxMcY for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 06:32:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EF09B408F9
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 06:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639031531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGxYW/i2o6T83DzUiYtpl0Te2wL7mcPMqolUgsjb37E=;
 b=Z8BQFNLJzZazoGQEjHO0ZduEm/+haOjD+kj7ZmN7Zc/wGPbqQ4mhHzgWLhPueH8FG6Nl06
 oGCiOaTfI5LUsOu0ROJPFXrKxI9/ypAcIQTxKO74juBaG0TIlaKV8iQJ9Q2oi5wZKVUbvc
 cb6qVtoh8IUiZWoYQC29rhiYEYjSexg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-_ueZzm7dNzCiGEkOdZx5OQ-1; Thu, 09 Dec 2021 01:32:08 -0500
X-MC-Unique: _ueZzm7dNzCiGEkOdZx5OQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 771B51006AA2;
 Thu,  9 Dec 2021 06:32:06 +0000 (UTC)
Received: from starship (unknown [10.40.192.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 783FF19C59;
 Thu,  9 Dec 2021 06:31:57 +0000 (UTC)
Message-ID: <864db5fb7528c84b41bc6580eac2a9f1c3485721.camel@redhat.com>
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Date: Thu, 09 Dec 2021 08:31:56 +0200
In-Reply-To: <YbFdwO3RZf6dg0M5@google.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <39c885fc6455dd0aa2f8643e725422851430f9ec.camel@redhat.com>
 <8c6c38f3cc201e42629c3b8e5cf8cdb251c9ea8d.camel@redhat.com>
 <YbFdwO3RZf6dg0M5@google.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Jim Mattson <jmattson@google.com>
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

On Thu, 2021-12-09 at 01:37 +0000, Sean Christopherson wrote:
> On Thu, Dec 09, 2021, Maxim Levitsky wrote:
> > On Thu, 2021-12-09 at 01:00 +0200, Maxim Levitsky wrote:
> > > Probably just luck (can't reproduce this anymore) but
> > > while running some kvm unit tests with this patch series (and few my patches
> > > for AVIC co-existance which shouldn't affect this) I got this
> > > 
> > > (warning about is_running already set)
> 
> ...
>  
> > Also got this while trying a VM with passed through device:
> 
> A tangentially related question: have you seen any mysterious crashes on your AMD
> system?  I've been bisecting (well, attempting to bisect) bizarre crashes that
> AFAICT showed up between v5.15 and v5.16-rc2.  Things like runqueues being NULL
> deep in the scheduler when a CPU is coming out of idle.  I _think_ the issues have
> been fixed as of v5.16-rc4, but I don't have a good reproducer so bisecting in
> either direction has been a complete mess.  I've reproduced on multiple AMD hosts,
> but never on an Intel system.  I have a sinking feeling that the issue is
> relatively unique to our systems :-/

I did had my 3970X lockup hard once on 5.16-rc2. It locked up completely without even
sending anything over a a pcie serial port card I. 

I don't remember what I was doing during the crash but probably had some VMs running.

Since then it didn't happen again, and I am running 5.16-rc3 for some time
with Paolo's kvm/queue merged and my own patches.

> 
> And a request: any testing and bug fixes you can throw at the AVIC changes would be
> greatly appreciated.  I've been partially blocked on testing the AVIC stuff for the
> better part of the week.  If the crashes I'm seeing have been resolved, then I should
> be able to help hunt down the issues, but if not...
> 

This is what I started doing last evening, and I'll go through all of the usual testing
I do soon.

Best regards,
	Maxim Levitsky

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
