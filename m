Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6C4C433FE
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 16:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9A52E4121B;
	Thu,  9 Dec 2021 16:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5MssuM_UdF3W; Thu,  9 Dec 2021 16:03:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0CEDE41210;
	Thu,  9 Dec 2021 16:03:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7BEEC001E;
	Thu,  9 Dec 2021 16:03:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0341C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CEFCA80F8C
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id op5PNGjZF2Y4 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 16:03:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 152B280F82
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639065828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=88wBNbW8beVEscjJxOr5QDERAx5Xra/tbkHKBTuW1TQ=;
 b=BRNS2RgzQCSvnoDz+dQdeu07N8LZJuD1LVmosrH/HCdqpoCVeld5VSy1mX/JQ6HIOQoHQP
 tJ877I+dtilHJsn0MjRRAwbx7pY/pmOV/MDplxwLMS6onXjTLpemosnv9s9Pww7WBJnYEl
 C1an6mlM1NM+j6AriAfjbNGB7yJmblo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-Yh2kklBbPKGEB2Q_VM82HA-1; Thu, 09 Dec 2021 11:03:45 -0500
X-MC-Unique: Yh2kklBbPKGEB2Q_VM82HA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F65A101796A;
 Thu,  9 Dec 2021 16:03:44 +0000 (UTC)
Received: from starship (unknown [10.40.192.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57B326B8EA;
 Thu,  9 Dec 2021 16:03:41 +0000 (UTC)
Message-ID: <84b493880aecfed52bed62714df77497c46af2ef.camel@redhat.com>
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Date: Thu, 09 Dec 2021 18:03:39 +0200
In-Reply-To: <YbIklNHIFnREGFAp@google.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <39c885fc6455dd0aa2f8643e725422851430f9ec.camel@redhat.com>
 <8c6c38f3cc201e42629c3b8e5cf8cdb251c9ea8d.camel@redhat.com>
 <YbFHsYJ5ua3J286o@google.com>
 <3bf8d500-0c1e-92dd-20c8-c3c231d2cbed@redhat.com>
 <346f5a5e93077ba20188a9b0e67bb3a44e2cad48.camel@redhat.com>
 <YbIklNHIFnREGFAp@google.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

On Thu, 2021-12-09 at 15:45 +0000, Sean Christopherson wrote:
> On Thu, Dec 09, 2021, Maxim Levitsky wrote:
> > On Thu, 2021-12-09 at 15:29 +0100, Paolo Bonzini wrote:
> > > On 12/9/21 01:02, Sean Christopherson wrote:
> > > > RDX, a.k.a. ir_data is NULL.  This check in svm_ir_list_add()
> > > > 
> > > > 	if (pi->ir_data && (pi->prev_ga_tag != 0)) {
> > > > 
> > > > implies pi->ir_data can be NULL, but neither avic_update_iommu_vcpu_affinity()
> > > > nor amd_iommu_update_ga() check ir->data for NULL.
> > > > 
> > > > amd_ir_set_vcpu_affinity() returns "success" without clearing pi.is_guest_mode
> > > > 
> > > > 	/* Note:
> > > > 	 * This device has never been set up for guest mode.
> > > > 	 * we should not modify the IRTE
> > > > 	 */
> > > > 	if (!dev_data || !dev_data->use_vapic)
> > > > 		return 0;
> > > > 
> > > > so it's plausible svm_ir_list_add() could add to the list with a NULL pi->ir_data.
> > > > 
> > > > But none of the relevant code has seen any meaningful changes since 5.15, so odds
> > > > are good I broke something :-/
> > 
> > Doesn't reproduce here yet even with my iommu changes :-(
> > Oh well.
> 
> Hmm, which suggests it could be an existing corner case.

Could very very be!
Next Sunday I'll lean the AMD iommu code a bit closer, and see if I can spot more bugs in it.

Best regards,
	Maxim Levitsky

> 
> Based on the above, this seems prudent and correct:
> 
> @@ -747,7 +754,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
>          * so we need to check here if it's already been * added
>          * to the ir_list.
>          */
> -       if (pi->ir_data && (pi->prev_ga_tag != 0)) {
> +       if (pi->prev_ga_tag != 0) {
>                 struct kvm *kvm = svm->vcpu.kvm;
>                 u32 vcpu_id = AVIC_GATAG_TO_VCPUID(pi->prev_ga_tag);
>                 struct kvm_vcpu *prev_vcpu = kvm_get_vcpu_by_id(kvm, vcpu_id);
> @@ -877,7 +884,7 @@ int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
>                          * we can reference to them directly when we update vcpu
>                          * scheduling information in IOMMU irte.
>                          */
> -                       if (!ret && pi.is_guest_mode)
> +                       if (!ret && pi.is_guest_mode && pi.ir_data)
>                                 svm_ir_list_add(svm, &pi);
>                 } else {
>                         /* Use legacy mode in IRTE */
> @@ -898,7 +905,7 @@ int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
>                          * was cached. If so, we need to clean up the per-vcpu
>                          * ir_list.
>                          */
> -                       if (!ret && pi.prev_ga_tag) {
> +                       if (!ret && pi.prev_ga_tag && !WARN_ON(!pi.ir_data)) {
>                                 int id = AVIC_GATAG_TO_VCPUID(pi.prev_ga_tag);
>                                 struct kvm_vcpu *vcpu;
> 
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
