Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFCE22FF4D
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132418; cv=none; b=uB/o0e4gvvyq/K1OsEPHKoTF4HrWLHw3L9fYzosFFc+ptizSwXd7TXljKDDtgmjQ8OOSpLZfHnuRu55V0mFruCFxicgZ8MkReSJNCpK7EuYvT6cRfNkplJc2T7E+gQDNcX7jk7uoUgVKuJ5yIbUhax9FP8VNi1r3eeZ7253sleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132418; c=relaxed/simple;
	bh=nnw9eJ8KOGN5QlUkiDoYliONcmf9ltltrlpJBMq/rPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFftBj9oNV+h8zpMicoZJGHiKK4ptQjz6LcIOWSaHjcyAw+sHzErCyce0kKVD/Aj0dwbxnYyobchnQEsE+Ik6xAKIGQnugjCPKN2iQJx5IRpqhg4d7+Np8v1L1t0/qozQx1DcwpQGGBYp/INvoB+8pigLSK05PzzCRdFElscBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DW9ZlNho; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DW9ZlNho"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54954fa61c9so3853563e87.1
        for <iommu@lists.linux.dev>; Tue, 08 Apr 2025 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744132414; x=1744737214; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st5xjw/A21tQtkt6th/OJeKKznmds9c4r1pftIhJsuU=;
        b=DW9ZlNho8Qy4MsFu1kVsswU483KxddT+3SBWW/h48myNkIPI4juEy/tRcQL4UanK8Q
         +ChVwjhnnkp/2dXyKo67sUFSYGxpgED5paF2FM+m5fPnc/W9ZQ5WdDl0a/qWI41qgLQ/
         cbiojJet7KAkPu9cIUacqFWEmINxrjWFWrZxV3fdmIbHaPc7IgJ2aC16ye7CuAu9q2t8
         y422Pf2JprUnTG+yVYtW3dQIO2JTaH/R3lb6AQjeDF0f4FTOKJslW87mvJI6iPMnp5Js
         0JlRoYrPRqAFoH3wZwEquHuvusWd43yHCeuuoI2ByWg2N4y5H/VxIROR0qruzrFrSlDZ
         e6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744132414; x=1744737214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st5xjw/A21tQtkt6th/OJeKKznmds9c4r1pftIhJsuU=;
        b=oCjXYnkhoRdaj3Wi5KB6nr6qV1riSpfAV7/rrTxHsDWnMokg8u3GaSAgu0Yd1X9XMX
         KFu9IzdTchlOwghSVU9eiyDRA63HvrTpTHp+p0TgDv62RFU9Gls6/HHaXOXoc8Xo30Ge
         qco+idWtU7KJfR8hhlqYW0RyXU1hQQ9zFbQBqX4c16sno/LRANri7gW+IVco7oZCf2eN
         qeBaT3QCfHkuhYS4LZzbG4p3/dUVzM1AKRZhTSqMsJ6MXf8fkD1b5nLcYGGZtQnom/HK
         7fnkbmvtQIxeFdfAworAeS7w4NZgt5LB0YnybUbcezj7j6BgZjllJBuuqK2ngN3Sm4MA
         mOmg==
X-Forwarded-Encrypted: i=1; AJvYcCUWnuIRnXFsCsj/c/Yw5zxjnI1li7i8DzC//7O6vcHeECSmijQJVNFsdq6Kd7MLbXge2DcG6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYNJb3i4lVXUPMqISFad0vekHJGTX+ZICqAougS9lnyMAvECN/
	RKesIWRMIUWHvzbBs+w4pPwG5fmOw4TuX9PgbWp+QBZbQ5S8h1JAskbm7/OZtIZTOFEEqFKH6xQ
	04VzHo5YhGTWgm45YiJZD73RyFBP+045zRuOI
X-Gm-Gg: ASbGnct8WQvfK2axc17cTKl9HHTD1HaZ1DUuaY3DQXLVKFhu2CipGmGR5L+5fPjBws+
	z4qZJoT/PNGkUaCtkR3dUCa/BlWnpZd5117er7k9mSZg+nimX9d3CdLG4wLkkfTtdpB7AbLsmGi
	iFOiqro2AzWyn3le38f96GiNhfGQ==
X-Google-Smtp-Source: AGHT+IEojOGt6jWAwX5Gcm/P2e+H5jOlOGkH6KU9klaguOraWZfMNwVU/6kY9rYk7qohNkpmZ9j0DjdTIdgt0Ju7HmA=
X-Received: by 2002:a05:6512:118b:b0:549:8f01:6a71 with SMTP id
 2adb3069b0e04-54c22808c0amr4933383e87.51.1744132413969; Tue, 08 Apr 2025
 10:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 8 Apr 2025 10:13:05 -0700
X-Gm-Features: ATxdqUHtXVL6zBbBDHxkUQLM1RAtccgSreGFrNU_ZXaEoEaE0jP24eQuxtxkag8
Message-ID: <CALzav=dMSLy7kt6sJtRqAK8tOZwFz9Ktp3vzqggdD+J_aPVycg@mail.gmail.com>
Subject: Re: [PATCH 00/67] KVM: iommu: Overhaul device posted IRQs support
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 12:39=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> This series is well tested except for one notable gap: I was not able to
> fully test the AMD IOMMU changes.  Long story short, getting upstream
> kernels into our full test environments is practically infeasible.  And
> exposing a device or VF on systems that are available to developers is a
> bit of a mess.
>
> The device the selftest (see the last patch) uses is an internel test VF
> that's hosted on a smart NIC using non-production (test-only) firmware.
> Unfortunately, only some of our developer systems have the right NIC, and
> for unknown reasons I couldn't get the test firmware to install cleanly o=
n
> Rome systems.  I was able to get it functional on Milan (and Intel CPUs),
> but APIC virtualization is disabled on Milan.  Thanks to KVM's force_avic
> I could test the KVM flows, but the IOMMU was having none of my attempts
> to force enable APIC virtualization against its will.

(Sean already knows this but just sharing for the broader visibility.)

I am working on a VFIO selftests framework and helper library that we
can link into the KVM selftests to make this kind of testing much
easier. It will support a driver framework so we can support testing
against different devices in a common way. Developers/companies can
carry their own out-of-tree drivers for non-standard/custom test
devices, e.g. the "Mercury device" used in this series.

I will send an RFC in the coming weeks. If/when my proposal is merged,
then I think we'll have a clean way to get the vfio_irq_test merged
upstream as well.
