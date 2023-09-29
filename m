Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BBF51B88
	for <iommu@lists.linux.dev>; Fri, 29 Sep 2023 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696009340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNuw9E3jfISKMJANhElE3yZ8P7q99O6Yz29XsBOWCUM=;
	b=caAofMvlr1cthonJcSGkYY7mGlUL37xVTeuviQwmbi6tmgs+55F+PzZ0qKbqtw1XvX1wSG
	fNdVUNK6yk57nJP7ZWzhdQOaOrD7QotULtZ/ixp4GtS+PkdvX6O6ODk7FNr1pU+Jx9ptYx
	34N5lLy2WYVwnWaD4Pny26po9H5wvrs=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-6b_N5RDeNeC16eg3bViIhg-1; Fri, 29 Sep 2023 13:42:18 -0400
X-MC-Unique: 6b_N5RDeNeC16eg3bViIhg-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7abc5f4a087so5852484241.1
        for <iommu@lists.linux.dev>; Fri, 29 Sep 2023 10:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696009338; x=1696614138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNuw9E3jfISKMJANhElE3yZ8P7q99O6Yz29XsBOWCUM=;
        b=momyRaCdIeYzdHFFWMXgksw3JOC22cUCs4ffHz0xLQ22xASAQ7rbI/PCH7/Kofpddm
         ZVkZhCeom7sTL1hgwK4QFKhP0GWA/AN2N5+JiTqooNUA0mmn9n6ESIT5A0W5Dl7/kuiG
         jMRtLpDF1NgHyUtkkRrWm7kIurtYL9Hzav461zBF8qEZ0pdMQ69W1uxFpvsW9lqlz79m
         VhpjSECEPBKOtsnXYwRU2ZC9fWAIUCe7Z+K64Z1tptSMQP/G2gO7Qoge/SAjomzEJ/he
         kflZuxHyHEmuIfELJT//nu2yIs3glVSg1Rpghvm87DyZQ/mfDCZEPdql9zoWc7YpxPSu
         UQVg==
X-Gm-Message-State: AOJu0Yzdn1mExdrbBqM/Fbt9IPkO1ciD1518IdE1SNqHzykKvKU9Lakg
	jtez39P5mSEznVm4Eh2P7Rvcf0hriPjX0wVjpUTJj0yjRTnfBMPuUJ4GLt5vmYAJj1kiMdjXYkn
	gqzgDn1E6mDhjy+8WK6ER/SxIb2ki2I4=
X-Received: by 2002:a67:e210:0:b0:44d:5a92:ec43 with SMTP id g16-20020a67e210000000b0044d5a92ec43mr5037061vsa.24.1696009337905;
        Fri, 29 Sep 2023 10:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCp/AIdWPqEWbtC/9JPny903uCy02I1/BqXTOfQT6TzjBnF4NJ5GNkVAKN/E+OvugdC1agXXOcQyVdpUbSE60=
X-Received: by 2002:a67:e210:0:b0:44d:5a92:ec43 with SMTP id
 g16-20020a67e210000000b0044d5a92ec43mr5037044vsa.24.1696009337587; Fri, 29
 Sep 2023 10:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230928173354.217464-1-mlevitsk@redhat.com> <ZRYxvdmHpjxr3QKp@google.com>
In-Reply-To: <ZRYxvdmHpjxr3QKp@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 29 Sep 2023 19:42:05 +0200
Message-ID: <CABgObfYhtHS3d4m07+qAxPzdR_jZ4Q9OC9K=Tf4sviH1Nn5cyw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] AVIC bugfixes and workarounds
To: Sean Christopherson <seanjc@google.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, iommu@lists.linux.dev, 
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Joerg Roedel <joro@8bytes.org>, x86@kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Robin Murphy <robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 4:09=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Sep 28, 2023, Maxim Levitsky wrote:
> > Maxim Levitsky (4):
> >   x86: KVM: SVM: always update the x2avic msr interception
> >   x86: KVM: SVM: add support for Invalid IPI Vector interception
> >   x86: KVM: SVM: refresh AVIC inhibition in svm_leave_nested()
>
> Paolo, I assume you'll take the first three directly for 6.6?

Yes.

Paolo

> >   x86: KVM: SVM: workaround for AVIC's errata #1235
>

