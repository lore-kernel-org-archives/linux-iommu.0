Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6913254A7
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734626; cv=none; b=Yn7yRxoXbC+ZqWo35P5kxeUxwFq9E4QtPdmn19/3pC9RUd/1gh8KNoStV/qqlGrabH0tY3GDBYDabbJLsBVdxNwauN7P3d0AcE4v1FfqqAsGrIcPJD9a14PYYpz4K8jvSIRHX1CLa+3Twac9BSAvrXuMnXmxwHAfE2QRaM3Bv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734626; c=relaxed/simple;
	bh=2oXoC0z5iX1QVctIx7be9YVECKd3qVj+JpFkjgooT/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VRLOuKTIyDAu9mzKoKO1aqa4hLwY+QeLd90m9mK/OUAdNkSjb+KsotUKVpAVcSQNpAA3pZUJI+Z7laBSSqDoIu0bJRjPakwhIcumFqgGa1AZcFBQM/a8rUti+XG3TgdhRglf4xYH6uWufHL0ulYik10SafXf4RAIhkK0geLYrcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEII69kv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEII69kv"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so3636385f8f.3
        for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 03:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761734623; x=1762339423; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcoHF11ENhR3RrvSYHkD59wUi5AUsDEUQzjKh8Eb0i0=;
        b=HEII69kvVxkn2cawmgwYyTNmw+u57bX4x4lMs/7hip+v4Tbqu7CXYXo10dwW6rEox9
         lcTCxlwXb+7X54K/pG8BBcpwBWR9XYaAv+Oo5z49aDxCcj2ZnQiz3SpJZeBknj5YbH0W
         aLS1obQ2osPbzL6wJnco/jx/rbD2RGDGD70qbQ+xypNvLZyvsJGeUp71ahZ0FwHG1IHO
         ROiPcUiALDywCditlHFyzZUri44e0dY6UHFBO4rje5F95Rw13Y3/oxSNt30KkBQmItlo
         5G10JjrowN3JimotRt8no7kMu+unGihUTSxrspl2g+YSmjPqfQjUKaGmetRAfqqW0Gbn
         A3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761734623; x=1762339423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcoHF11ENhR3RrvSYHkD59wUi5AUsDEUQzjKh8Eb0i0=;
        b=hd4i3k59qHOVNcYL/RQ6rlRP5Wo6DBU2ifP8lUB4aq+wH+kx3AvuugkrK9Hh+tw3rB
         /Psz1d3MCNKuAga5GQE0d71txeHiNimiJUVD6KO4YAXBogFnKpsdD+YbkT3iXoueUVlk
         7Clknb+ee/AMqtv9R+wiSubpwWsz1BkxV/fZ6aGdGBgwiXiRAS044rj2FVA44ZrATvfV
         mDKRwrrHOXRqFRc006SATc4h4Vg3jDd47SM+unOCkCapgMCbj5iKksJkdFsC4Fb4h4aC
         1EQTtTM5UdQ567rmVYJDnjWsyltlbAhTZE9iHqU/KGrq3+MRBleUpc9BAYTqrMbQGBXt
         z8fA==
X-Forwarded-Encrypted: i=1; AJvYcCWotg/jk+GO1SI5FBhqOcwL6d6BdJBW6f8HqXTICtMmZgAZqUPmUrLkG3VehCiO71lwHHbhzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzcxyifmSLoBrfJSxgfGg83KEL/VjnKGY7Uks3cMFqi/6pcZRt
	c0ReR/MJdhwvKlMaqpz6Mj5bhrEgPVhfBzCPveuQSE/Se8EcVt4Qw2v+
X-Gm-Gg: ASbGncsnafxIl/b8evRpVtUz9c9OYwOC5ylhTl2W+2L77sBq8B4UA0YstJ9P91BEQBY
	FbWfd+7Ksb8MBii4VqDqBIhh72W/T0DowgeHpO0PQLgcyaRb4A/qeRHvnM+OD6e8Lh9hMF19wH3
	ENU5N70WTMZ5qqZeq+3EwVA107zAvbBODYAQ6ZdS5XmL5/LoJ9eGVMhB8R5B+/iSqERI5nOfD8e
	yNwuEyO0Ib5sP5S+kDDo1O3NjiNDnisj/IRA7jyf1TDZ4QzMAOCWpPNa0Pxe03z4rjS6HEF/gJD
	3MTSe3iaf0sJ9ALHmuZU0++WRyL/VOsMYZqpL9iQIBt3uqC9JcS3HbloUFOZU9Gen7sshpuEzpm
	QdUqVHajYPe5Ks2BevB1dpjKBq/ACY5mBQP4ucVSaO8aeIn7892PgqugTMHtwP42ZoHKT/NhLRA
	HoGv3N
X-Google-Smtp-Source: AGHT+IEmRI4Z/M00oieKbPxeIQldJKpH25/9dKm0itRMgfx3Wj6z2aQjBwr5JnK2lV2Z2mKsh3XAaQ==
X-Received: by 2002:a05:6000:240f:b0:427:a27:3a6c with SMTP id ffacd0b85a97d-429aefda93bmr1775484f8f.63.1761734623193;
        Wed, 29 Oct 2025 03:43:43 -0700 (PDT)
Received: from vasant-suse.suse.org ([81.95.8.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm28137267f8f.45.2025.10.29.03.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:43:42 -0700 (PDT)
From: vsntk18@gmail.com
To: ashish.kalra@amd.com
Cc: Sairaj.ArunKodilkar@amd.com,
	Vasant.Hegde@amd.com,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	iommu@lists.linux.dev,
	john.allen@amd.com,
	joro@8bytes.org,
	kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.roth@amd.com,
	pbonzini@redhat.com,
	robin.murphy@arm.com,
	seanjc@google.com,
	suravee.suthikulpanit@amd.com,
	thomas.lendacky@amd.com,
	will@kernel.org
Subject: Re: [PATCH v6 3/4] crypto: ccp: Skip SEV and SNP INIT for kdump boot
Date: Wed, 29 Oct 2025 11:43:42 +0100
Message-Id: <20251029104342.47980-1-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d884eff5f6180d8b8c6698a6168988118cf9cba1.1756157913.git.ashish.kalra@amd.com>
References: <d884eff5f6180d8b8c6698a6168988118cf9cba1.1756157913.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

   these changes seem to have been overwritten after
   459daec42ea0c("crypto: ccp - Cache SEV platform status and platform state")
   has been merged upstream.

   I can send a patch if that's not been done already. Please let me know.

Thanks,
Vasant

