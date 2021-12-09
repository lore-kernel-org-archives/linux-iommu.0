Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9945FC433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 06:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49E7D82CCB;
	Thu,  9 Dec 2021 06:36:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1qd5Huv6OqVu; Thu,  9 Dec 2021 06:36:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0C1EF82C8F;
	Thu,  9 Dec 2021 06:36:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABF80C002F;
	Thu,  9 Dec 2021 06:36:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EA8FC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 06:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73A21408F9
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 06:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bSbq64UvFxe9 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 06:36:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B56B94041B
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 06:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639031813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsK4QJUaSZXa5TJT2c4xQUlL2CmJjpAOfFB8ZXJJNPs=;
 b=iDTglN9v7bchWvVtYUbuArRtBGuuK5imbytpFIj2YmIEVl+tigZmr10UJPzfar6XYjjH9P
 qbQJhFXnO0CXzlNqEhGoUNuRLHU08pJ0MRHvC0llHE+hxYlcQuX9rqGxKtVhw9o6Cu3Yfx
 ZXll3CZLwKutXkordu0rGujwVnkYiag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-77QLfWBEOm2RkS8nX1z5Gg-1; Thu, 09 Dec 2021 01:36:50 -0500
X-MC-Unique: 77QLfWBEOm2RkS8nX1z5Gg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12A86100CC99;
 Thu,  9 Dec 2021 06:36:49 +0000 (UTC)
Received: from starship (unknown [10.40.192.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BC0D19C59;
 Thu,  9 Dec 2021 06:36:45 +0000 (UTC)
Message-ID: <e87ba370fd853452e763cf36c1cf94fa251185de.camel@redhat.com>
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Date: Thu, 09 Dec 2021 08:36:44 +0200
In-Reply-To: <YbFIGSeukbquyoQ5@google.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <39c885fc6455dd0aa2f8643e725422851430f9ec.camel@redhat.com>
 <8c6c38f3cc201e42629c3b8e5cf8cdb251c9ea8d.camel@redhat.com>
 <6f0dc26c78c151814317d95d4918ffddabdd2df1.camel@redhat.com>
 <YbFIGSeukbquyoQ5@google.com>
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

On Thu, 2021-12-09 at 00:04 +0000, Sean Christopherson wrote:
> On Thu, Dec 09, 2021, Maxim Levitsky wrote:
> > Host crash while running 32 bit VM and another 32 bit VM nested in it:
> > 
> > [  751.182290] BUG: kernel NULL pointer dereference, address: 0000000000000025
> > [  751.198234] #PF: supervisor read access in kernel mode
> > [  751.209982] #PF: error_code(0x0000) - not-present page
> > [  751.221733] PGD 3720f9067 P4D 3720f9067 PUD 3720f8067 PMD 0 
> > [  751.234682] Oops: 0000 [#1] SMP
> > [  751.241857] CPU: 8 PID: 54050 Comm: CPU 8/KVM Tainted: G           O      5.16.0-rc4.unstable #6
> > [  751.261960] Hardware name: LENOVO 20UF001CUS/20UF001CUS, BIOS R1CET65W(1.34 ) 06/17/2021
> > [  751.280475] RIP: 0010:is_page_fault_stale.isra.0+0x2a/0xa0 [kvm]
> 
> ...
> 
> > Oh well, not related to the patch series but just that I don't forget.
> > I need to do some throughfull testing on all the VMs I use.
> 
> This is my goof, I'll post a fix shortly.
> 
Thanks!

Best regards,
	Maxim Levitsky

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
