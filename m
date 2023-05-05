Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA415383
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683307220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=h8x5vOq5JCCT5bWH/vjUcsB8VgrpUJMFJLzU08VpZ7M=;
	b=JnYZROhtTOsC0B+/HZsKTXI6GXvq0ID7L+mJLgQLV8gSIX1lAGDnbBk2H05A3eThe9N60t
	Q33XZ7emes+a+l2QgjFPphKXLWs9waCNJyS6skJdpZnoPkX9SPChz8lFjyN6UKUeFBmxyC
	xCUier4le75E9ueLsvoEZZgnUchO914=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-M8GgaL9JMZqhQuC7Hm4xRg-1; Fri, 05 May 2023 13:20:18 -0400
X-MC-Unique: M8GgaL9JMZqhQuC7Hm4xRg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-5efc80e8485so27445886d6.0
        for <iommu@lists.linux.dev>; Fri, 05 May 2023 10:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683307218; x=1685899218;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8x5vOq5JCCT5bWH/vjUcsB8VgrpUJMFJLzU08VpZ7M=;
        b=GakprIvS9KSHC8T4+S9ApTjHn56+79MF2RnnM462inW9ZKvSZJFi9VyAmTpEdBOSKM
         8A0lDv3J6RHkRlsSrOa2uEaS9OmUFoysumOEScHcRimAS6LIRVxbtjP5J1mK3t9nVVLe
         /PvWTbCqNnGD0QUbBcQNP2ghzT1uamef6+F2UN65IEUpwsi7unQjI/BN/bmnSa084gTv
         tnQ/OM9FL77Sn4aCmxq+bCL2X8hW/18GQVEuWriGWmJIz0R+3z3ViGpm/FnR3HJzzjDw
         LAUCIG0gj371bFOpDv5SPuXb+3gb73zN84FoulVkhNYMy9a/A0sCXtaTLLYOpVb4BPTm
         8Idg==
X-Gm-Message-State: AC+VfDyy2EkPrU01CwHN5kFGr8d/cuVkg6T9QMnTgsRrdKzc96QVtZbQ
	Dj2GEM+6JlFE0eyt+dFX0UPAKwd1Zz0x4JHdhBeVlFdP+3AF+4FBNqAmz2TaDu02FL9k1oLVwaw
	5SPvLYovy9aN8snLxSDnmJ+7rNbXtolK0Xz3oZjNrhSDMF3TK4NkpbyCqNQrQGRK3Cd2cwUTiyq
	8=
X-Received: by 2002:a05:6214:2462:b0:5df:47e2:8df5 with SMTP id im2-20020a056214246200b005df47e28df5mr3572272qvb.31.1683307217989;
        Fri, 05 May 2023 10:20:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4xw3a3P0dWTJyEMPslUQbB5L4rARnBMqCtmpddI+DwFtKmD6mDPdFS6W0/OhwA1O3s0C+xpw==
X-Received: by 2002:a05:6214:2462:b0:5df:47e2:8df5 with SMTP id im2-20020a056214246200b005df47e28df5mr3572242qvb.31.1683307217652;
        Fri, 05 May 2023 10:20:17 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z12-20020a0cf24c000000b0061b7bbb7624sm715096qvl.130.2023.05.05.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:20:17 -0700 (PDT)
Date: Fri, 5 May 2023 10:20:15 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux.dev, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baoquan He <bhe@redhat.com>
Subject: kdump issue seen on certain platforms with active E810 connection
 and intel_iommu=on
Message-ID: <5mntwytbymhkpj5sweefamjczikvuc6vf3hwdlltxssn6qg72l@fnfwpf2asxj7>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I sent email to Baolu the other day about this, but wanted to send
this issue to the list as well to capture the info here. My current
thought is that this is an issue with the platforms themselves, but
I could be missing something.

It was originally seen with a RHEL8 kernel, but reproduces with
the 6.3 eln build.

I've been looking at an issue that involves the following hardware:

1. E810 network controller (ice driver)
2. HPE DL110 gen 10, and HPE E920t

When doing testing of kdump they see the systems reset during the
probe of the ice driver during the crash kernel boot. Further
investigation found that there is a pending interrupt according to the
pci status register for the function, and when the pcim_enable_device
code path clears INTx disable in the pci command register the next
thing seen is the system resetting. Adding a debug print after it
doing the write to the command register never shows up. I don't know
if I could try something else there. It appears as soon as the device
asserts that legacy interrupt once INTx disable is cleared the system
is gone.

Some other data points about system configuration:

* intel_iommu=on
  Does not reproduce without intel_iommu=on
* iommu.passthrough=1
  Reproduces iommu.passthrough=0
* intremap is enabled
  Reproduces with intremap=off

Prior to forcing a crash of the system if you check the pci config
space of the function there is no pending legacy interrupt. Debugging
also shows that, as expected, INTx disable is set and the pending
interrupt bit is clear in the status register after the ice driver
sets up msix.

If you boot with pci=earlydump you can see that by the time the kernel
gets to setting up pci config space in the crash kernel there is now a
pending interrupt for the function.

If you set iommu.passthrough=1 there are no reported DMAR faults
and the system still resets.

So far this has only reproduced on these models of HPE systems. I
managed to get access to an HPE DL380 gen 9 last night, and while it
gets the pending interrupt on the E810 the system does not reset
during the ice driver probe.

The difference between the DL380 versus the others would be Haswell vs
Ice Lake, and C610 vs C621A chipsets. All three systems show the same
values for the gsts register:

GSTS            	0x1c		0x00000000c7000000

I think it likely is either an issue with the platforms themselves or
the firmware. I don't think the iommu code would be behaving
differently on the systems, but I could be missing something. I would
expect the problem to show up on the DL380 as well if the iommu were
the source of the issue.

I'm trying to reproduce on a non-HPE system as well, but getting
access to one that has an E810 hooked up to a network is taking
time.

What I still don't understand is how dma remapping being enabled,
especially with passthrough, could be impacting an interrupt and
whether or not the system resets.

Does anyone have any thoughts on what could be happening there? My
view is it is something below the kernel with those platforms, but I
could easily be missing something in all the parts that get involved
with iommu, apic, and kexec/crash code.

Regards,
Jerry

