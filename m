Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18CD1F09AD
	for <iommu@lists.linux.dev>; Tue, 12 Aug 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020711; cv=none; b=b03yvIy1I8vhFlzMPVJzLHjO8wO1XwpVR7sm4dqd9sDjA/TIq96kXEnQXyQn5FPJ/E21iyL9ANlQs6CDZozJb7UKjYTQIuikdCVSbHXWHJgsgqyx/d9hX0WFNTKAja1HWj/kg8bFQhhjCZrG91We5ir8WvB9MV+sjQlzY7UDSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020711; c=relaxed/simple;
	bh=eySWvu6D2G+rUPX+8K39gjMe9CUI5RHiIFd1y9r7B6k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HUey6N760VfuCpmaduwJPaG59sJEIi0SAnK84GMA6OnRNlQiKtmm1FF5Sa9kHC1SRVZOSyTuELSQgJezEsua15V0B2jzrdqABMsL919Wy9C2PSsEH5kzWW+HARSI5G84iiRHx9q+AyVTC7AXgIAeKZtVMMbgF13YawPe0k0halI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b1fd59851baso3902356a12.0
        for <iommu@lists.linux.dev>; Tue, 12 Aug 2025 10:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755020709; x=1755625509;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmYFxaQaG6Ge1u212H8n0v8lC5zbtgjVzdaqY71rvgY=;
        b=VxD/zO89To4l1HgXhGEXwPEXW2wQWJTeQLRvnrXghwmf66nAZ+sYS+aHuLJe0Wkagg
         SnyMjDIf9BKPF70ghFasiAd8RUTnXf5qK6/o22IHyGnb65QA3KTwBuhjSksOd3eaecE/
         RqYe4HIJfstGLVqN7pqdDnIxuHifrU0JWpjP8HA2V8Nh5uPuOUXcYLVDtQLxagn5i1fa
         XvJgqE+Fq5oEnSv72AMAda+Hub2l2Z3+SDvQdNclRW520UwUSuncYa+3jMLzy9pl/nXO
         AEaf698X7Muh2zZS8sTMXHQo/gVo3OA7r/8Qz7l7jUCBlrnlo5v4lMaxNoUtbz8+uIJ8
         KjbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFBX9YZNJJSnNeMAivGmYSb7RRNK4NW2Zshi8fNrD/LR6Kh0giCPpvxR8AfE7++svRSmkn/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrNrsl/nWE64TneLhlb8REEJgDhn0V2+IOuZKBAISo8JIib5h6
	vflSMDPIXbQc4g2BiLFZDgunBuF5EGgM/7ZZ0RqwHW5qpitUr6uq1Sy6
X-Gm-Gg: ASbGnctQuv9Jpb1ODDNKf/ppM16I+dHt05oFBkOoEwNwIQ0ifK5oilgcZcv8j0sNVKZ
	1e/7TEt6J0/PsSSww3oa7d8CIk6x19OLfy4gnTNVHuvpesQse581S3eOjT2A6fAe7+uxW5Sykam
	V5RcJvuM7ESEKHM3yALcr9JTK7GAR1P/3gQc/EZnsdWPcA0mk3NbdVkseKbdK+H/YyNxIpxCLME
	eWlzqQfmWZXA7hOlTD5LZ5+0DtAUboSXsZYPRHjihyn2uV4nhTn3P2em9alQmJWYMaQLwTCFjke
	Tx5yCjRyC7Pu/ovt8KwKTxfBUME5gjMekB3oAWliqLzBH72eGOg2SEhDO7vuaeZagEieyA1OZNP
	cMncThzjl37ZmBucxexpxfE+Zqu+SDGpg/1Oe76HEEhXsg7Va7oKa7mXv3w==
X-Google-Smtp-Source: AGHT+IFmpr89BCHty+5y7Jx5cKjOzvj7jSGWi9gqY9TLJzLs/GRC8uzyhVcwbrBQipVlogt9TDUHqQ==
X-Received: by 2002:a17:90b:4cd1:b0:312:f2ee:a895 with SMTP id 98e67ed59e1d1-321cf9e87dcmr552975a91.31.1755020708889;
        Tue, 12 Aug 2025 10:45:08 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3216125b7b5sm17519891a91.20.2025.08.12.10.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:45:08 -0700 (PDT)
Date: Wed, 13 Aug 2025 02:45:06 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>,
	Linux KVM <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: The VFIO/IOMMU/PCI MC at LPC 2025 - Call for Papers
Message-ID: <20250812174506.GA3633156@rocinante>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello everyone!

On behalf of the PCI subsystem maintainers, I would like to invite everyone
to join our VFIO/IOMMU/PCI MC (micro-conference) this year, which will be
held at the Linux Plumbers Conference (LPC) 2025!

The LPC conference itself will be held this year on 11th, 12th and 13th of
December this year in Tokyo, Japan.  Both in-person and remote attendees
are welcome.  See the https://lpc.events web page for more details and
latest updates.

You can find the complete MC proposal at:

  https://lpc.events/event/19/contributions/1993

Plus, as a PDF document attached to this e-mail.

If you are interested in participating in our MC and have topics to propose,
please use the official Call for Proposals (CfP) process available at:

  https://lpc.events/event/19/abstracts

The deadline for proposal submissions is late September (2025-09-30).

Make sure to select the "VFIO/IOMMU/PCI MC" in the Track drop down menu to
submit the proposal against the correct track.

Remember: you can submit the proposal early and refine it later; there will
be time.  So, don't hesitate!

As always, please get in touch with me directly, or with any other
organisers, if you need any assistance or have any questions.

Looking forward to seeing you all there, either in Tokyo in-person or
virtually!

Thank you!

          Alex, Bjorn, Jörg, Lorenzo and Krzysztof
