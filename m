Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31819191484
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916783; cv=none; b=kDv3IQXfbA8jqeevK7ea7/+3RobVfwtsXK1+WuvGH+JHl9j/bltKCPstxacNsF7uEZDLBsleaQxKh7VIqd+x34iC7qeef+BWg9QWM2mzFPdhdCcaHZ5c0gUjLLe22aKTbByu211F8dCRtHDjAUwcNOEIV0z9BwytfrBzw2veckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916783; c=relaxed/simple;
	bh=uOMaXxqQr1touZc2JkhdpC0WTA9CS+H9FhkB/6PIUEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFFocV1wr8IKcLDgEgKR3syuDcpEKgGF/8XY4lYuJVLEknmZbR1Svivn3Yr2gtlDUzI+NZbpHZvErxyZAdJTnANCvyA++G0WZHOpwDBKOlr93va0CRv3vPcHob0cezPhF4al+bN0lgkBeaFxX2APMGcHq33/QGC/t4rj4gsbFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf3d64849dso937677866b.3
        for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 08:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742916777; x=1743521577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiWm+JkA0WFLQavBGxgJxiDDHRCBaxXFyxmdg7dNgng=;
        b=EcFanDkMaLvaoaGpkxf8SxyoihwubCoRc56jVN0WIvewmNuQPHCzW4yelRP0xA3/uL
         U/MywWF96nfjDswp/A0jupzqssyZZ82SzuISNfk9JWSPPyM3xZexqpghE6C3UHNTUoxb
         kVSPyx32xTguQgIN9E3KibqKHQMEWVixyDj8AYqb6dm2MOtulR/2XkKBpsssX/yrI8HJ
         fcElgQRm25K5uLCTkxf+CMd34sQf6NF/HA28Du3Utde4S3iYWAQKIsSp9ITu5AS6dRpf
         SDukeep4+4ulBG+L97k7LGH8yhM/yzeSdFhmtqrw79lL95s70AVHBwBUjiU9TowdUfY5
         WB+A==
X-Forwarded-Encrypted: i=1; AJvYcCWUkhLLCbd+iJmRXR3qcYWqECuGp2ktxNavoQyHvjRO7DHVubU7vexsQBfgvw+9Vo56oFB3wQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrrH5x1Q6DbA5gAXs9aN26zFux1E1cBp5HoAj64PefdoRlY/lt
	hZUfQjtqimiirhJjSK8ugg4Cg2G/1PhzZDyqArdkbquC7CxfcO6NBCJk3bHGTB4=
X-Gm-Gg: ASbGncs1JGVfPtgcyArCb6e+ymW5rb+GQtvQ+b98z+GjGarpFLJCDjkevKJmPfGtOGo
	uRfSkcGa0qabuO2bSN/wxtWX3K4PsQYyVepRINM2fgzj5ChTnvBjXSS9l6KNajUbKg1V/5F64fP
	VWczreocaOVzZupGc/KKD+3qeVe4Rf23D7zz5oLeMZXswKocnOjt1PC+Z19IIuKS9GGlh9wpswn
	4grWOqzl+WOkoBUwMfMcgfLayI4tHeozgBXqFMU6G1+K/he31mYFm3GlsXYUbA+U2K269EjQI/0
	DdRJUDfIxA/KRnxhaKGdupKhoMZH3Jo2ApoCrb1GjLSH16idSowz8qS/yAq6hnVq6i9zMPDTC5H
	C+d2MnJc=
X-Google-Smtp-Source: AGHT+IGuZWf9hjfjCVfmv3fGER9KKHR0GuzgxtPWA3dRCKjs17tgNq1Ed5l+dP8ucawrJXMP+4aWbw==
X-Received: by 2002:a17:907:bd0d:b0:abf:e7c1:b3bf with SMTP id a640c23a62f3a-ac3f24163f7mr1881325866b.11.1742916777205;
        Tue, 25 Mar 2025 08:32:57 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcce36d66sm7930432a12.0.2025.03.25.08.32.56
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 08:32:56 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2963dc379so971054066b.2
        for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 08:32:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZGt46wIqNqBh1Erv6B7gJjRGMPOlvyUghNlk2/7Qg4YtndAT137O2j9hJVScpthQWwCa5bA==@lists.linux.dev
X-Received: by 2002:a17:907:9494:b0:ac1:de84:dec0 with SMTP id
 a640c23a62f3a-ac3f24ed6c4mr1547143566b.26.1742916775525; Tue, 25 Mar 2025
 08:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1740753261.git.robin.murphy@arm.com> <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <CAMuHMdWPFnHTFeeWL2-BU8tKOL-E5K2ROOz=LLBLTJJLCK9NgA@mail.gmail.com> <25bd5477-a388-405f-a976-6b1a59860ef8@arm.com>
In-Reply-To: <25bd5477-a388-405f-a976-6b1a59860ef8@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Mar 2025 16:32:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXt9gQxBSVrWw1VSji+faxga4Vo_NRie27K=EtdUMMa_Q@mail.gmail.com>
X-Gm-Features: AQ5f1JoGJs3g1Wq6ZLZNBkuvqix5EpionY5Jl_k8v4NSQBsoSN9WndnQ0FJE0b0
Message-ID: <CAMuHMdXt9gQxBSVrWw1VSji+faxga4Vo_NRie27K=EtdUMMa_Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe path
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>, 
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	Charan Teja Kalla <quic_charante@quicinc.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Tue, 18 Mar 2025 at 18:24, Robin Murphy <robin.murphy@arm.com> wrote:
> On 18/03/2025 4:37 pm, Geert Uytterhoeven wrote:
> [...]
> > Thanks for your patch, which is now commit bcb81ac6ae3c2ef9 ("iommu:
> > Get DT/ACPI parsing into the proper probe path") in iommu/next.
> >
> > This patch triggers two issues on R-Car Gen3 platforms:
> >
> > 1. I am seeing a warning on Renesas Salvator-XS with R-Car M3N
> > (but not on the similar board with R-Car H3), and only for SATA[1].
> > Unfortunately commit 73d2f10957f517e5 ("iommu: Don't warn prematurely
> > about dodgy probes") does not help:
> [...]
> >      Call trace:
> >       __iommu_probe_device+0x208/0x38c (P)
> >       iommu_probe_device+0x34/0x74
> >       of_iommu_configure+0x128/0x200
> >       of_dma_configure_id+0xdc/0x1d4
> >       platform_dma_configure+0x48/0x6c
> >       really_probe+0xf0/0x260
> >       __driver_probe_device+0xec/0x104
> >       driver_probe_device+0x3c/0xc0
>
> Hurrah, this is the warning doing the correct job - something *is* off
> if we're now getting here without the IOMMU configuration being done
> already (for a normal device with no other funny business going on).
>
> > 2. The IOMMU driver's iommu_ops.of_xlate() callback is called about
> > three times as much as before:
>
> That would suggest that the fwspec gets set up OK, then something later
> in the __iommu_probe_device() path fails and tears it down again, so the
> next attempt starts from scratch. Do you see the "Cannot attach to
> IPMMU" message firing?

I do not see such messages.

> And similarly to the Rockchip case, does the
> below help?

The below is basically the same as your "[PATCH] iommu/ipmmu-vmsa:
Register in a sensible order"[1].  While that fixes my first issue,
it does not fix the second (harmless?) issue.

Note that I only noticed the second issue because I have local debug
code in soc_device_match().  Perhaps it happens, unnoticed, on other
systems too?

Thanks!

[1] https://lore.kernel.org/53be6667544de65a15415b699e38a9a965692e45.1742481687.git.robin.murphy@arm.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
