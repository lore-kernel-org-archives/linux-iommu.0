Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6880A2744D
	for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVysohYa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697722357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpNttNMYuxYrg++tZJU7aHSjMPEAnzSMQI0OyzamccU=;
	b=MVysohYauDGYOKeKweDgX0MSVSvOuxv2VlspHPthcscXCk/Kfqk4POb9wKMl1ECHtHjyrY
	IKc5goVvOmodcQx791eLTUO6koyrCzrDRbuD3ukb+e0N2uWp4jEP/AESJhwXsatzr40isU
	fO0ak7DJcRCVdFfa2YQTvN8MngiWUF4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-7AJwBZUqOHmHbNiRs38PMA-1; Thu, 19 Oct 2023 09:32:35 -0400
X-MC-Unique: 7AJwBZUqOHmHbNiRs38PMA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4083a670d25so13482635e9.0
        for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 06:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697722354; x=1698327154;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fpNttNMYuxYrg++tZJU7aHSjMPEAnzSMQI0OyzamccU=;
        b=Bnbuyz9EH4988tvACTrAgm9VmhQ+fNDISFFEuA4WFQlZRhiPdfAWsNzjA3SUevAzPY
         fzvrx5hTTKEM2C3mcTmew2UAdiwCuuWY1uzcmuE5XZt/QOwsxgB8NtWjBHByWPlvubYZ
         o/l9NXyW54UGc831tECIWECyTkw0Ak8xZVgKP8nj7GH/0er8tMeqvDSQl9dcd09SNQAq
         q1mjJ8xkhYkMXlkcJ+6tf1yIxMJzVKSQul9N2MEzdGGfiGj5Gz+RpadlnmrnNHEtoEi8
         BdxwGjILpM+h51VqO14pAA2lDHOAlVa/Rrt54x3ANuDgCLdfKmR1VJVylzmNvkc/vdYQ
         U0Sg==
X-Gm-Message-State: AOJu0YwnlqFlFed6Jo09/8kDEKVvFUe2VoAPkzz2W/1D9C/vUuNxmrrT
	xkDdXqd3KGLninhyzW+yG1tHhqilg/MXU4RZ1bybouZ4XuRkO+nm1h3ZBYeSbJ09d99FyHmwS4N
	tH2KdSas8vD+UeMQ=
X-Received: by 2002:a5d:424e:0:b0:32d:a977:50b0 with SMTP id s14-20020a5d424e000000b0032da97750b0mr1532508wrr.41.1697722354441;
        Thu, 19 Oct 2023 06:32:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFslkzbUAqoUOogMxd09VoVqSQdX15OcXnRTo8QWDZTS0esTZfwchO0AaQAH0PHqc9G3zTUGA==
X-Received: by 2002:a5d:424e:0:b0:32d:a977:50b0 with SMTP id s14-20020a5d424e000000b0032da97750b0mr1532481wrr.41.1697722354061;
        Thu, 19 Oct 2023 06:32:34 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id d3-20020adfef83000000b0032dc2110d01sm4500447wro.61.2023.10.19.06.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:32:33 -0700 (PDT)
Message-ID: <f5e41b0e277924c757c22c8ed6db19c6dddfe9f0.camel@redhat.com>
Subject: Re: [PATCH] iommu/amd: Do not flush IRTE when only updating isRun
 and destination fields
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: joro@8bytes.org, seanjc@google.com, vasant.hegde@amd.com,
 jon.grimm@amd.com,  santosh.shukla@amd.com, joao.m.martins@oracle.com, 
 alejandro.j.jimenez@oracle.com, boris.ostrovsky@oracle.com
Date: Thu, 19 Oct 2023 16:32:31 +0300
In-Reply-To: <d0731c73-b2bb-972f-a728-f63273c4d5ab@amd.com>
References: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
	 <97d106d28e4c3468912a478dba79ab2221109cbd.camel@redhat.com>
	 <44477b0b-af38-569e-95d9-e78c118c9d18@amd.com>
	 <d0731c73-b2bb-972f-a728-f63273c4d5ab@amd.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2023-10-19 at 16:11 +0700, Suthikulpanit, Suravee wrote:
> Maxim,
> 
> On 10/17/2023 10:36 PM, Suthikulpanit, Suravee wrote:
> > On 10/17/2023 9:51 PM, Maxim Levitsky wrote:
> > > У вт, 2023-10-17 у 09:42 -0500, Suravee Suthikulpanit пише:
> > > > According to the recent update in the AMD IOMMU spec [1], the IsRun and
> > > > Destination fields of the Interrupt Remapping Table Entry (IRTE) are not
> > > > cached by the IOMMU hardware.
> > > Is that true for all AMD hardware that supports AVIC? E.g Zen1/Zen2 
> > > hardware?
> > 
> > This is true for all AVIC/x2AVIC-capable IOMMU hardware in the past.
> > 
> > > Is there a chance that this will cause a similar errata to the is_running
> > > errata that Zen2 cpus have?
> > 
> > Please let me check on this and get back.
> 
> Just to be sure, could you please tell me which errata number are you 
> referring to here?

Hi!

The errata is this one:

https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/revision-guides/56323-PUB_1_01.pdf
(ERRATA #1235)

The errata meaning is that once the CPU sets is_running=0 in AVIC's physical ID table, 
the hardware might still not cause #incomplete_ipi vmexit, for a few times.

This means that KVM is not notified of the pending interrupt and it lets the target vCPU block instead of being woken up.


In regard to the IOMMU, the parallel errata like situation would be that CPU sets is_running=0 in the IOMMU tables, 
exactly afterwards an interrupt arrives and the IOMMU doesn't log the interrupt in the GA log.

Note that regardless if the IOMMU works correctly or not, the KVM has to check IRR after it sets is_running=0 to avoid memory
reordering races, but it does so and uses a memory barrier to ensure correctness. 


PS: Recently I realized that a very simple workaround exists for errata #1235: At expense of the performance, the KVM can
permanently set is_running=0 in the AVIC's physical id table.

This will ensure that all ICR writes except self IPIs will cause a VM exit, thus in the expense of performance will
ensure that AVIC works correctly.

And this configuration while slower than full AVIC, it's still much better than having no AVIC, 
because AVIC still accelerates the receiver side of IPIs, and also IOMMU can still post interrupts.
In fact with the workaround applied, AVIC is exactly equivalent to Intel's APICv without IPI virtualization.


This is the latest version of my patch series:

[PATCH v3 0/4] Allow AVIC's IPI virtualization to be optional
https://www.spinics.net/lists/kvm/msg328416.html

A help with a review will be highly appreciated.

In addition to that I would highly appreciate if AMD could respond to these questions:

1. Is the errata #1235 really not present on Zen1 CPUs? It doesn't appear in the revision guide,
but I still suspect that the guide might just not be up to date. I haven't tested a Zen1 machine
to see if I can reproduce it yet.

2. As I see AMD disabled AVIC on Zen3 machines, but it does appear to work just fine in my testing.
Is it possible that the reason for the disabling is also related to ICR/IPI emulation and that if I apply
the same workaround as for errata #1235, then AVIC could be safely enabled on Zen3,
despite support for it not being present in CPUID?

If I know the answer to these questions, it might be possible to enable AVIC on all current AMD hardware by default.

AFAIK (my personal opinion, based on various downstream bugs opened and their urgency) that our customers do care about APICv,
but somehow assume as a fact that AMD doesn't have such feature while in fact AMD does.

So I think that if AVIC were to be enabled by default on AMD, that would be something that AMD's (and ours) 
customers would appreciate very much.

Best regards,
	Maxim Levitsky

> 
> Thanks,
> Suravee
> 


