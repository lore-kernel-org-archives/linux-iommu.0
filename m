Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF52FE58F
	for <iommu@lists.linux.dev>; Tue, 12 Aug 2025 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021637; cv=none; b=AIy+MMIuJjVGnx4OmOKS4uTwWKdsUL061aSVpWefnzqaf0HaJAY5IK+ObPY7gLtpYqcFY7rL/DDM+RqWI8xrAF4Dv+G0F870veZyfwFCtBaX/+3uQ3Ruy4xRq0f3qzmT2DA9XIg/LyFXXA5sw2AHXaZkHupffirnBq0IqhEWHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021637; c=relaxed/simple;
	bh=s5HtP8zgPfB8LKfRkpw96pL5pDbdt4mOdR/STsv8WgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu0KCDSGoD1sbG0mmFb2RirhVY0Lq0SbLy6xBISVEnkKhrFoppRhJFnwsiN0peD9quJLKe7aKv//Tm6lyKLyMAxp86f4E0YyV4TKE5ofhx01l1+sKrW0/nhuiLRZ7egyPYpyrd6AaQg8VoT1smrg5nSrxlKW9nebLOnY2yz4GcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31efc10bb03so4988395a91.0
        for <iommu@lists.linux.dev>; Tue, 12 Aug 2025 11:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021635; x=1755626435;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5Ko3ZCMWMZkG6/L2zPaHNNIdKij+I5lWVdC3qk6HiI=;
        b=S8F558qupIlaXLku/0JMn/xSko1AzB1t9S8i8AVloW4YRl8hZxGRfv3z6D0GnAOAB4
         f3etlRSnykVoAib500vhwAlySRqqxpCNNVUB1TySx+BYewsWCeK9nZZgnheefBpvEkFF
         roVFjGfliZ8zyapAvu3wgQ4tU8VUCNVMUNYthYADnhnWByZ6n0s99NwtUKBW8ZDU1mF0
         5mfXJRkkOyqucrYlFXJfc9VrPUL8y/d7Ka++HsewQKK3ic51Vp1hcCn2KpXpwzwFlQgs
         H7tFwwHiTCB7dItJVjaTii4izVeonL2i8SQW9E40qKO9FRiwjQK7x9QRS0Idw4mF/2VT
         gvlw==
X-Forwarded-Encrypted: i=1; AJvYcCW3HX//QqNuh7g35DDiscUiScFt2RlSzGL+Ms2QsCeKFo2NjobsB3hfRZr2iYqZZPaLR3v3xQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJ+HpsVft1Y3WQgeYA/bE172Ua90rQVqc0xgz0YIA/QzLie1oO
	yShEzXa+rrUYst3l91lHL0h6KQEjVI1oZnOFwLdoTudagVio2IIqau6l
X-Gm-Gg: ASbGncvp8+0H9rx7tpU6WtCceCZ7GTLll3gsUc9dHHQ/g6GPBWGNKJRysMTECxziQA+
	qJDfayWWAcCpLdlxptRsitErmGKYPc8GNrW9uf9xZf4ptrjJh1wbxFzuBVSALfkytHYmCp/7uLj
	BuVee3gjOWgVEsrHkM9NAh+m0MIJfU+mcrVOZRIZhui02HycUSeIH1iEmQwbvUNIibMeiHu8m44
	phsL+ma1w03jmaOGI9KlOudny7Whk4pxG/K/CIBNhz7Tm9y8vYTMkreb9cAL0OwHNpSec2B0lca
	i7ZIOm1UUtwRhHpsmGoV12lJb4AMsAsGdY7m3heoIoeivwAn6s2IzC+9x0FGQgqI/zRMZwKZOkO
	dEs0UvT4wFoUrejFC1MrgSwXZ/1UNkZ6DIQ5NLAo1q/yKiAOeoLXtj46CdA==
X-Google-Smtp-Source: AGHT+IGUwKjcxYIQjXRjsgyfhPfJbPlIzcS8JQODwmaqlP1k+KdKPRhYL2FuhDCZiKF95kOWUmZ07w==
X-Received: by 2002:a17:90b:5543:b0:312:e9bd:5d37 with SMTP id 98e67ed59e1d1-321d0d6719bmr718a91.6.1755021630632;
        Tue, 12 Aug 2025 11:00:30 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32161259329sm17810958a91.17.2025.08.12.11.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:00:30 -0700 (PDT)
Date: Wed, 13 Aug 2025 03:00:28 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>,
	Linux KVM <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?SsO2cmc=?= Roedel <joro@8bytes.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: The VFIO/IOMMU/PCI MC at LPC 2025 - Call for Papers
Message-ID: <20250812180028.GA4020767@rocinante>
References: <20250812174506.GA3633156@rocinante>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250812174506.GA3633156@rocinante>

Hello everyone,

Adding Jörg using his new e-mail address...

> On behalf of the PCI subsystem maintainers, I would like to invite everyone
> to join our VFIO/IOMMU/PCI MC (micro-conference) this year, which will be
> held at the Linux Plumbers Conference (LPC) 2025!
> 
> The LPC conference itself will be held this year on 11th, 12th and 13th of
> December this year in Tokyo, Japan.  Both in-person and remote attendees
> are welcome.  See the https://lpc.events web page for more details and
> latest updates.
> 
> You can find the complete MC proposal at:
> 
>   https://lpc.events/event/19/contributions/1993
> 
> Plus, as a PDF document attached to this e-mail.
> 
> If you are interested in participating in our MC and have topics to propose,
> please use the official Call for Proposals (CfP) process available at:
> 
>   https://lpc.events/event/19/abstracts
> 
> The deadline for proposal submissions is late September (2025-09-30).
> 
> Make sure to select the "VFIO/IOMMU/PCI MC" in the Track drop down menu to
> submit the proposal against the correct track.
> 
> Remember: you can submit the proposal early and refine it later; there will
> be time.  So, don't hesitate!
> 
> As always, please get in touch with me directly, or with any other
> organisers, if you need any assistance or have any questions.
> 
> Looking forward to seeing you all there, either in Tokyo in-person or
> virtually!
> 
> Thank you!
> 
>           Alex, Bjorn, Jörg, Lorenzo and Krzysztof

Sorry about this Jörg!

	Krzysztof
