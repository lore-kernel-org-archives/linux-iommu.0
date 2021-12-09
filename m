Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801ECC433FE
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 14:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 219876121C;
	Thu,  9 Dec 2021 14:48:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNxX2Qwbqu7o; Thu,  9 Dec 2021 14:48:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DF9EE6118D;
	Thu,  9 Dec 2021 14:48:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8D20C002F;
	Thu,  9 Dec 2021 14:48:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53395C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 14:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41A5E41F1C
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 14:48:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FkRtF6WhkNcg for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 14:48:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97B3041F1B
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639061315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9ohOzueGM6Q6CzM/nc70ucDOBZyHf1ga4ugF012GdQ=;
 b=FGAE+0VwoHpdcyMslmLgggllA5rPWrRgbbyMxXJiu/jlzUpTqmHjs9MD9Aqqy2B3zvL6AA
 J3/6Z2SAwFIM7tE8AgreKMYhI+5i48hpONxzzFvGLd+6Mt8fjzjz18VVHouLDQSyKUXMt6
 a7l21l4LwNXDDj0wQl9Zv07Ss/CTam0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-bzWYdvgnOhOv5cycTJfqQQ-1; Thu, 09 Dec 2021 09:48:32 -0500
X-MC-Unique: bzWYdvgnOhOv5cycTJfqQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2462A343D8;
 Thu,  9 Dec 2021 14:48:31 +0000 (UTC)
Received: from starship (unknown [10.40.192.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A1B760BF1;
 Thu,  9 Dec 2021 14:48:26 +0000 (UTC)
Message-ID: <346f5a5e93077ba20188a9b0e67bb3a44e2cad48.camel@redhat.com>
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>
Date: Thu, 09 Dec 2021 16:48:25 +0200
In-Reply-To: <3bf8d500-0c1e-92dd-20c8-c3c231d2cbed@redhat.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <39c885fc6455dd0aa2f8643e725422851430f9ec.camel@redhat.com>
 <8c6c38f3cc201e42629c3b8e5cf8cdb251c9ea8d.camel@redhat.com>
 <YbFHsYJ5ua3J286o@google.com>
 <3bf8d500-0c1e-92dd-20c8-c3c231d2cbed@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>
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

On Thu, 2021-12-09 at 15:29 +0100, Paolo Bonzini wrote:
> On 12/9/21 01:02, Sean Christopherson wrote:
> > RDX, a.k.a. ir_data is NULL.  This check in svm_ir_list_add()
> > 
> > 	if (pi->ir_data && (pi->prev_ga_tag != 0)) {
> > 
> > implies pi->ir_data can be NULL, but neither avic_update_iommu_vcpu_affinity()
> > nor amd_iommu_update_ga() check ir->data for NULL.
> > 
> > amd_ir_set_vcpu_affinity() returns "success" without clearing pi.is_guest_mode
> > 
> > 	/* Note:
> > 	 * This device has never been set up for guest mode.
> > 	 * we should not modify the IRTE
> > 	 */
> > 	if (!dev_data || !dev_data->use_vapic)
> > 		return 0;
> > 
> > so it's plausible svm_ir_list_add() could add to the list with a NULL pi->ir_data.
> > 
> > But none of the relevant code has seen any meaningful changes since 5.15, so odds
> > are good I broke something :-/

Doesn't reproduce here yet even with my iommu changes :-(
Oh well.

Best regards,
	Maxim Levitsky


> > 
> 
> Ok, I'll take this.
> 
> Paolo
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
