Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794803668;
	b=weWeUYtUMGJJABvodZ8M6qlrn2+tASBDJ+QwBYOoJW5z2IHWUnNW0Yp9kOlyN7QyMATT
	 xCj1qRMrjBIEw/VIdazjT32Dzz6wf6yex3qLNaz2yhkRsW5J18OvPUMjD66ccLrEAfenk
	 9ASL5/Z3lbGfIpPeSguW3VORkM2THGUVkutitTbYWtH0isgSB8Ku2GhzoAdo098VqG58g
	 6AZo4gjmhckSuBJhLstctIWIO67mxaSe1imiO+LrDhcGdulyRYag9YYCxNkr6L/ohT9Q1
	 HqS9uuDEWYhiR3AIa0t3aQ9MCHk+/VQzyXxhQ9C13UpnLzuIHcmyi5l7fEDsV76mOGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794803668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=;
	b=Q4wRh3UMm+gOnX4AHrrXN4228ijCRSUP3f/qzLbl9oRlzDgDNPXakCyb5SKiYGdW8mrX
	 vyIkQBXpd9pJvWQaTLDapJJ5dBArXLa8v1Atqu2fCJngvZXjvYqzOPvvDRiO5VJ81Xz4s
	 lMw2b3UHs2aOGoYhZw+czhO+Zwe7pUKaqoQ+0mRV6Q/Spz5bOgWwDI3cHBeJre+oaddDA
	 4DGit+wI+Lit4Dx2zFTfSrGpHy7UXeSZzQ1MvDNWdhAopnDOAjjnfYujYfm/cr60NzFDX
	 4KZitOBTooxf1TzBgSEd9Ejw918yCXhoP0yu5wmWHSODmvexpniJxMtNuFSLVr3+TtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=cqzcMzVi;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55A606A336
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 04:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA55A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=cqzcMzVi
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1aefd1bf74aso2245495c88.1
        for <iommu@lists.linux.dev>; Sun, 15 Nov 2026 20:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794803667; x=1795408467; darn=lists.linux.dev;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=;
        b=cqzcMzVi51jTgL2WyAIpZSPzXVevFHpbhWzwV700sK615AdMRuqZwL2dBbqfHSMXI4
         iC87LBWT7dZ91JqA6EPATaa/Wwr3Y0wDvJ4ZajTqVww/xjWAPQHDYh52fxoasl56Uznq
         rQGb0X2NmZ7yvdl/u021U5v8VhEJjBUYrentc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794803667; x=1795408467;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=;
        b=Yaj0jUohO9OHRKx5Q3+NVN0PO5gpApk9WORScrWqSP4njhjcSygcxW9RNkix474FpL
         /JUS2giz8sB5kJ82Stas9HmzaKw0GffSDYRyU1Y4fnN98u5Hhn569bLbPtKWisfIj2vH
         6+wAaA1u2Objxr4d05ISVJdLvM6tzaF2WA8+xX4PMh27YnhTQFBvCqmr3lDDSrR4uUhs
         mbL5gk2lEfDvmo7fTXwHsNcR9Fu/s9DemFMCfwe2e/8/9qluKN8NupnHZY0bXmC4WZKe
         m0prmbb0G26K8FwoLuJufJTYqpmjFSNcy0Y4cLJTzfMzm+CvsJmyk5CDsGd9R6YF5Gyi
         uwxw==
X-Forwarded-Encrypted: i=1; AL+hErGqETXHDKXB4GbIaVH9DM8cFam+Shz3QQyZB4yD9nBrR6iancGLdh37WbxSTHxw9ui4eDHNig==@lists.linux.dev
X-Gm-Message-State: APuU4Z8zeqKXQ9afrt+aEvPh4YLnVPxnszj4rBBRBgG2WJlmnrRSYryw
	7ALVu0fgZJqhtGm4YQDVOgzYqkhq4xw4HTOqzvwF2/WC/OqKAwXiXBjN8ofvMoG8Ca0=
X-Gm-Gg: AYBFou1WxLsmvYi/0jmHcQ6gtlysIb/KGk/+TLbI8o4AsPb51w2BqcFo5cRA/QD80Jq
	eeZab8EJEEOkhnfD4U3UmxXBYIq59+kHvv4JgMuAr97Cin9W0q6UvsR81XQebVoIfjqxtdgAuMi
	5FWJJDsARa3S3W1BUAdl+wQSL9asJYhqiHAP27T6WYFYQ0WT+7k6xFbKd5rN/pHkFvEkfBVx/TY
	IYFhqEBZpYYQJ4CHpHo2q5VtQA6DhYPJh1R4fUOZ7sN5Ok2I2AhlLtFLXWhf3JLLgnuw570MK+v
	+Qa/ei9OjtT5OBvu/jyPTtXrCLWp63VHEYQelmUTj7RtDXz3AOKv58D8n8fe/fKVR4JUV5KfSXg
	B656vMPHcN8BzQyq4tVEPcOi5xgeUG61ObpWWCCPw773b8rrso2GspjHJKCOu8RJNkJe8gYj9Q8
	0OfdF2E8qJd+mJ7a0Zu68wwLi6PlOsCb4l79S0s1hN2IEoKiAu8cyJHvSgPkOsT84sDE5Z96hhl
	l7AbpxpdsalZAF8PqrZnRui3ZpNKDFl3INEKHRXzq9T26GF/oyJKcUXbITnImg6K6TVzOeiNnAZ
	H0IybJDNRFdgIFxrI7HwRWRW6wYVhD8Z+zoQkI4VMRUOKXxmcmzb1yg5G/uFdf9TR3A2+v1/Xdi
	YfkZ3pxzpYyH0IuMB1/CwwTuAuakwZYKAZEqvNMCDBit/hIyOFdp4qqnn8lTz7UPgeBrUxTzq7d
	F1kJBgotFduv2qO9t2kL9treF2BNALMPGQgh5XsHJP1u/T4LRZyOcnnfCGPz+p8YTY
X-Received: by 2002:a05:7022:b0c5:b0:181:6b8:31f1 with SMTP id a92af1059eb24-1b4f5f3475fmr11110443c88.10.1794803667022;
        Sun, 15 Nov 2026 20:34:27 -0800 (PST)
Received: from [172.18.0.2] ([172.56.232.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm38362148c88.9.2026.11.15.20.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 20:34:26 -0800 (PST)
Date: Sun, 15 Nov 2026 20:34:21 -0800
From: Chris Down <chris@chrisdown.name>
To: tarunsahu@google.com
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org,
	will@kernel.org, David Matlack <dmatlack@google.com>,
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com,
	loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com,
	joro@8bytes.org, kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
	compatibility
In-Reply-To: <9huz5wy4tufo.fsf@tarunix.c.googlers.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-6-tarunsahu@google.com>
	<DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
	<9huz5wy4tufo.fsf@tarunix.c.googlers.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261115203421.38c206b35f5b12e6@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Tarun,

tarunsahu@google.com writes:
>Techinically this is just for readability.
>
>WDYT?

It doesn't help readability in the generated docs, though. kernel-doc
splits the parameter list on the comma inside the macro, so
kho_preserve_vmalloc() comes out as

     int kho_preserve_vmalloc (void *ptr, DECLARE_KHO_SER_HDR(kho_vmalloc# *fhdr))

and the struct memfd_luo_ser and struct luo_session_ser definitions in the
ABI docs end up with a member like

     DECLARE_KHO_SER_HDR(kho_vmalloc folios_fhdr;

I'd go with Pasha's suggestion and use struct kho_ser_hdr directly. The
pointer can then say which payload follows it with a comment.

Chris
