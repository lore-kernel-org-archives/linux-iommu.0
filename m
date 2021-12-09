Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C5BC433FE
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 15:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50EA485439;
	Thu,  9 Dec 2021 15:45:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R3np7tctHNMd; Thu,  9 Dec 2021 15:45:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 38A4B8543B;
	Thu,  9 Dec 2021 15:45:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 131F2C001E;
	Thu,  9 Dec 2021 15:45:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37EB8C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 15:45:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18B7F422B0
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 15:45:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nNzElOCzkgcq for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 15:45:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86EFB422A7
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 15:45:29 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id m15so5394291pgu.11
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 07:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DMB6spvibGxVU/+VTs+sCniEDJa7q1WtFQnSMx4TKv0=;
 b=JL3ywlMl+rqRWktZIQaSKNPRmDzI/JO3XCKiJ8r7GZIJxKRbuMrdFvJsbWt1pYioh9
 josJ5RJh5Y7Gyd5B1O4mVdtBWDNnScai+DDi5wWJSYT2NFXcDASTnNem11dZihnx5dgI
 5O8EEPZhSK8bche/ll7QO96eeHWRqH3SaozruBdVk6+2nMJ2qDDNNWWvIU2HLyMU70UE
 6L9viCV8FiEWMQtB4VxXBEyefmhmBVeEERG/AfMc+wu+/rM/NbrrxDKgd2fzbiUODYOc
 HFj2lkeeIM06mojzvzfu3yDjvsVAmtVLVsuaIdYN2RrouQl4LdB+8G8WqMk/sFE1rF9C
 6C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DMB6spvibGxVU/+VTs+sCniEDJa7q1WtFQnSMx4TKv0=;
 b=zNwImkZGfhZ48pG4youWjWdqa5GqYrTXMAYO9UNSifA47SaqfCiAgQxKGZTUDC0MQs
 oLgJOwHmLAuP5UnvZRvwyBJRocET7JuBId1DzzJ+aUh7/kHhV+o9rUI5zHuFzJS0NgX5
 MfnxHYoFOngOmgsipKEsAOEPIjok4DUW5cU8/4Wi/VXM3QB512GqJRlDpWoReASrZP5F
 tt5AUiO721+MrxXw5I7dJfmS8aS+/FzKailIGkl4zGJwVT1JQUccfjUSx8I9K/8BzNu1
 hnhzS3Mhmb5KMxli40w2RGpYTQcQm1gcXFNcOWCgg6J3vpSKiRNvlBmZKet3gIqUTnNR
 xcqw==
X-Gm-Message-State: AOAM53277WNo68HNFT4NdyH0N9ttu7+udB0ttXQGBu4//SKOob+l2yXW
 kWcMnFTYTVkE++HBbJPgv2kUtQ==
X-Google-Smtp-Source: ABdhPJzfr6ZOaNUFGkDN7LvTK2YY1tb9EksA+oA91YEVzv4A177yuuGRAMZuUgWC4VV06/F+8PoQbw==
X-Received: by 2002:a05:6a00:2349:b0:4a8:d87:e8ad with SMTP id
 j9-20020a056a00234900b004a80d87e8admr12456531pfj.15.1639064728692; 
 Thu, 09 Dec 2021 07:45:28 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com.
 [35.185.214.157])
 by smtp.gmail.com with ESMTPSA id ip5sm131157pjb.5.2021.12.09.07.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Dec 2021 07:45:28 -0800 (PST)
Date: Thu, 9 Dec 2021 15:45:24 +0000
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
Message-ID: <YbIklNHIFnREGFAp@google.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <39c885fc6455dd0aa2f8643e725422851430f9ec.camel@redhat.com>
 <8c6c38f3cc201e42629c3b8e5cf8cdb251c9ea8d.camel@redhat.com>
 <YbFHsYJ5ua3J286o@google.com>
 <3bf8d500-0c1e-92dd-20c8-c3c231d2cbed@redhat.com>
 <346f5a5e93077ba20188a9b0e67bb3a44e2cad48.camel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <346f5a5e93077ba20188a9b0e67bb3a44e2cad48.camel@redhat.com>
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
From: Sean Christopherson via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Dec 09, 2021, Maxim Levitsky wrote:
> On Thu, 2021-12-09 at 15:29 +0100, Paolo Bonzini wrote:
> > On 12/9/21 01:02, Sean Christopherson wrote:
> > > RDX, a.k.a. ir_data is NULL.  This check in svm_ir_list_add()
> > > 
> > > 	if (pi->ir_data && (pi->prev_ga_tag != 0)) {
> > > 
> > > implies pi->ir_data can be NULL, but neither avic_update_iommu_vcpu_affinity()
> > > nor amd_iommu_update_ga() check ir->data for NULL.
> > > 
> > > amd_ir_set_vcpu_affinity() returns "success" without clearing pi.is_guest_mode
> > > 
> > > 	/* Note:
> > > 	 * This device has never been set up for guest mode.
> > > 	 * we should not modify the IRTE
> > > 	 */
> > > 	if (!dev_data || !dev_data->use_vapic)
> > > 		return 0;
> > > 
> > > so it's plausible svm_ir_list_add() could add to the list with a NULL pi->ir_data.
> > > 
> > > But none of the relevant code has seen any meaningful changes since 5.15, so odds
> > > are good I broke something :-/
> 
> Doesn't reproduce here yet even with my iommu changes :-(
> Oh well.

Hmm, which suggests it could be an existing corner case.

Based on the above, this seems prudent and correct:

@@ -747,7 +754,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
         * so we need to check here if it's already been * added
         * to the ir_list.
         */
-       if (pi->ir_data && (pi->prev_ga_tag != 0)) {
+       if (pi->prev_ga_tag != 0) {
                struct kvm *kvm = svm->vcpu.kvm;
                u32 vcpu_id = AVIC_GATAG_TO_VCPUID(pi->prev_ga_tag);
                struct kvm_vcpu *prev_vcpu = kvm_get_vcpu_by_id(kvm, vcpu_id);
@@ -877,7 +884,7 @@ int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
                         * we can reference to them directly when we update vcpu
                         * scheduling information in IOMMU irte.
                         */
-                       if (!ret && pi.is_guest_mode)
+                       if (!ret && pi.is_guest_mode && pi.ir_data)
                                svm_ir_list_add(svm, &pi);
                } else {
                        /* Use legacy mode in IRTE */
@@ -898,7 +905,7 @@ int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
                         * was cached. If so, we need to clean up the per-vcpu
                         * ir_list.
                         */
-                       if (!ret && pi.prev_ga_tag) {
+                       if (!ret && pi.prev_ga_tag && !WARN_ON(!pi.ir_data)) {
                                int id = AVIC_GATAG_TO_VCPUID(pi.prev_ga_tag);
                                struct kvm_vcpu *vcpu;


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
