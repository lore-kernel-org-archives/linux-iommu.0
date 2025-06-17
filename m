Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F82EAB7E
	for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750186371; cv=none; b=nVqNNSPXfAri1nNa5Xj2w5Blq2Z1JqBCkcwxXUkMnFOdWTRiXRILPAlYPwdDMIbbboRXjAu2bqM+sWOu6A5FT9ZdNlLlgQWTqGFQIFypSDnRruKv/lOJq2534wbduYb4Hj3eUALKeDHSrjw+Q8BEZTN1qb9sjGbiUA3Fb3NhH44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750186371; c=relaxed/simple;
	bh=+toRoMC/6o3ABSZSoj6kwUB+0AHRoQQb9StmVaDTJuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBWzSqfK5eZkf2DiKf9z9lJXTvc0x0i5m3LA7DKpcVkHjflFPY/9gwDAGle2TpZo9sG6kOjbjASSHa/UU7Q6U9W89C5D3EdFrcRY/dsFlA7OVbG3aIuCv1Blg29ohWbOjRo7mkbXGn2bnkWieb/9k7UtJ++l3V5jNu5SKrBVhoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKbeD3Wf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKbeD3Wf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750186369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7GR8b6oq+VKsS7zEblPcoLobXIu9Z0EZdf91JZ1evE=;
	b=ZKbeD3WfRCDTOey5Vy86vUt+ughS9QEHymGmXRC65wOlvVEG8ccZ3fM1zGrHpYMDh0GFov
	uK97ndKOJ5O0VB/hU6opVZd1bgxdZ1PY3HAdgG6iWsDW3gpj6KHMl6MZszfL+Ay9SDwZmq
	u9pYRVPKsB747QIeT9I1Rlgkn59Ytm4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-AKiCiNgCNO2hm-qDpGHb8Q-1; Tue, 17 Jun 2025 14:52:43 -0400
X-MC-Unique: AKiCiNgCNO2hm-qDpGHb8Q-1
X-Mimecast-MFC-AGG-ID: AKiCiNgCNO2hm-qDpGHb8Q_1750186363
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87333a93bd9so50996639f.1
        for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 11:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750186362; x=1750791162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7GR8b6oq+VKsS7zEblPcoLobXIu9Z0EZdf91JZ1evE=;
        b=mx/VD6Boa51HwBYQScbRQA17efmmBLqiNBPGOTHZ8Z7EgDvspYZBHJMaPwUus7vGXV
         1mhASHPu/FK4sOaaFHl93D9Q5zulOuXbyQ9M0iayiAlSsP/oFsRN3qNR68XzPd4DJ5kf
         AVa8c+1c4/gHxC/NR5C/2bhIYeGW09WxNFz6YviMMxpdbCrZzlU/0/A8Wzx+Sxgma0FQ
         K3rU3B4VR4JGuK7OzQFalbrfY4t2+teFntD/k1LBkY6KemqnJpJzBZWeURPaGZVBjWnn
         l0Zu4NPDDo8ESXVnWGc44ArYJWA6XgQPsDO0yHZFF4OcL05LE/ty+Nah5g5XaLIJEz/N
         noaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7/XfJJhIX8antwkZrC8M8ck5bELGbAmeYxwV6z4tbkLB5+lL5mLdJqAhQC6bRP25XjgBohg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYH3EUApQG2blCcQS2FzW891AAKAQDXbepjEXZ7pHGyorS/b7D
	ULpJYxvcoM4Cex9GwZgdBh9GithyM2TAaGyrl5gdFVOHlJwG3rWJIsOzpNbove7/mTFa+9x4mVL
	SA9HXPYT/t98MZ6gcTLwT7HT507nF8Z/rD2ygOJpjv8tI7DxTYgavDamu
X-Gm-Gg: ASbGncvG9BU7NVpyKicxBeTSO3pIuNypk9AE7fl9YpqGb1k7dbpB6Cm7DnEIAGFpGde
	+XYw92kn+aKDGyLZOGQ9EGP/28donjJ6G9+EBO5VQarj9sS40fKgjFr+EGuTz4vvlJ2jC5Z8Qjb
	L3fT8By1cv9GSjAp7b03HaPJyy4jyOcQOgYT9IJTWBX/ry8kUB/Hheo2H0Hnd2xe52tcI6MhR85
	RsUfQwPcGUxnLN5bPGNmU3a9lW63X99PFzs1DmDk+fNDlEFhPybuQDyliSHTuTmkOFO5kVUXW/D
	M1W0RZiqMnuX7siZBaRMt4Q3AA==
X-Received: by 2002:a05:6602:3414:b0:86a:24c0:8829 with SMTP id ca18e2360f4ac-87601391479mr183503839f.0.1750186362670;
        Tue, 17 Jun 2025 11:52:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKthDmryWBtQYhqN8X3vXXpFX6gedZAuw/STdWF8X1NR60JiUUJho0FZmRHCrhQiS9JYovUQ==
X-Received: by 2002:a05:6602:3414:b0:86a:24c0:8829 with SMTP id ca18e2360f4ac-87601391479mr183500639f.0.1750186362211;
        Tue, 17 Jun 2025 11:52:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875d5842a19sm225353839f.44.2025.06.17.11.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 11:52:40 -0700 (PDT)
Date: Tue, 17 Jun 2025 12:52:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list), iommu@lists.linux.dev (open
 list:INTEL IOMMU (VT-d)), linux-pci@vger.kernel.org (open list:PCI
 SUBSYSTEM), kvm@vger.kernel.org (open list:VFIO DRIVER),
 linux-sound@vger.kernel.org (open list:SOUND), Daniel Dadap
 <ddadap@nvidia.com>, Mario Limonciello <mario.limonciello@amd.com>, Bjorn
 Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 2/6] vfio/pci: Use pci_is_display()
Message-ID: <20250617125235.13017540.alex.williamson@redhat.com>
In-Reply-To: <20250617175910.1640546-3-superm1@kernel.org>
References: <20250617175910.1640546-1-superm1@kernel.org>
	<20250617175910.1640546-3-superm1@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zCh4BgGDeaBbJFuGYgm4GEwN_9kKDQswp8KaqyIUk7w_1750186363
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 12:59:06 -0500
Mario Limonciello <superm1@kernel.org> wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The inline pci_is_display() helper does the same thing.  Use it.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/vfio/pci/vfio_pci_igd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_igd.c b/drivers/vfio/pci/vfio_pci_igd.c
> index ef490a4545f48..988b6919c2c31 100644
> --- a/drivers/vfio/pci/vfio_pci_igd.c
> +++ b/drivers/vfio/pci/vfio_pci_igd.c
> @@ -437,8 +437,7 @@ static int vfio_pci_igd_cfg_init(struct vfio_pci_core_device *vdev)
>  
>  bool vfio_pci_is_intel_display(struct pci_dev *pdev)
>  {
> -	return (pdev->vendor == PCI_VENDOR_ID_INTEL) &&
> -	       ((pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY);
> +	return (pdev->vendor == PCI_VENDOR_ID_INTEL) && pci_is_display(pdev);
>  }
>  
>  int vfio_pci_igd_init(struct vfio_pci_core_device *vdev)

Acked-by: Alex Williamson <alex.williamson@redhat.com>

