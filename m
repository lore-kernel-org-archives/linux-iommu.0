Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71398160885
	for <iommu@lists.linux.dev>; Wed, 28 Feb 2024 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149098; cv=none; b=CEbvhjiS1M1TFTmfDUorH47qnObHDr9U0U2gImdbSUYn6ThfYBM5wuk3J8MnbQSJ3HSrjPGtTqCipJdrQNKlZKBvzwlMqpRZRax9BhRXdwO2FFEGO6Vc7+ArEv7pwfbgEs745bvObt9ABV6XqZQUgFM/eiS4iL5lZ+srkRUmmb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149098; c=relaxed/simple;
	bh=3mzdhPKAJw9K4mIZOxB1UV8uaho4YjxUkqlu9AvTtSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wj6w+dLZzineLkHc8k7Qewwg7TA5+Rt6LKdgK0NugyGW2AfPxYfoY6PCoqwkWEFPNs4hJb2L3rqN4T5XZmZsUCLX504kvN0K1iXDpoIdclaTLLfzBiytGEYZA108T/b++dWrqbWpHFUg5xc/0X7GzimEFDHGO5QJXh7sxMP5d5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHiqyOJ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHiqyOJ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709149095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67dIkbaqejGM9dM5+izpDf+P8kc9aAZ3gpV2PIdOLs4=;
	b=KHiqyOJ8dK/L1FeNwYRjUrOqvECrFX7b0w6UPzBkz93W7TpBoCFuxyV0QbvN7/NQqCcyff
	WIG9iYyZ9BLcY+YuZDcYiOkoiRmIJGW76n/Z2fx4fkARHGjIZm6kuDN1Nf2RAoT9aVXZWz
	ityanTuogTQ+LbZHwRCYan2TFWypqZo=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-6c7vIarhPwyozlvs5FFyTQ-1; Wed, 28 Feb 2024 14:38:12 -0500
X-MC-Unique: 6c7vIarhPwyozlvs5FFyTQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bfe777fe22so3237739f.3
        for <iommu@lists.linux.dev>; Wed, 28 Feb 2024 11:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709149092; x=1709753892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uA20CDAKsgM4Tx3YYjgPKLshZVqnm4Ew1QkRNRKLdZo=;
        b=Kmh3PMptjQ1TK1VP+DQAAdovLfQBoBylX5BG00u0pC5ByoBKEKuytpcrqUvFHmNNQf
         BZRUdNlTDxQmYVpaGkxaf3TKEcV/zPdhJf44cCI/wqiNwJ1PatLRPj6Mpn9K/AD3vAXX
         x221ItJ5cKHTLFJu8QmVwRYZSbkawYETH2N1HLh24SgG2wmfj4G/NwGIWc3h1hIlyn0e
         8cuNkwixcOdwL6+w60LAePFpxNg4pnZitkLvHfR2CmMAIrviji69Uhm16c4AKw2zd5p8
         ER9P+majx5wQy4QJkW/R+SjIKUXJb94OqnllrG8Wwqra62w8JaA1k3xHQ8CneLCt7NIF
         fdDw==
X-Forwarded-Encrypted: i=1; AJvYcCU17OtSCMPQteoj9YxTZIr7TnCGGeUmveanvi7IGdlBO2u86aTSj0H0qdHsDC+sIp+9aY1q7VSFtSdcP98J0+CNLQBqyN4=
X-Gm-Message-State: AOJu0YzcU8sEfE96DG5KVUGC6jW0ekdb+8/+QUKCAR6ztABqzJqD86Li
	/9AI6jDfwd3BiH/5xDdXiad2xZOZ2hFsMmkwu4pMHqL3H0U3ty+7VUficGCe/RisL+HFB4Wvnfs
	vFOHIxj9lZJ+vhPWI1vRvAFG78AKGuEfZCk4UXBVj1BdvWqgANsTa
X-Received: by 2002:a05:6602:734:b0:7c7:687e:41ba with SMTP id g20-20020a056602073400b007c7687e41bamr163495iox.9.1709149092243;
        Wed, 28 Feb 2024 11:38:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLbkc9moMLuoOGq7o7bm+s7c1gRZdMUmGNufsCw5nAB2hYAZNgiuYz111J6g0/Tgm8/E8rCg==
X-Received: by 2002:a05:6602:734:b0:7c7:687e:41ba with SMTP id g20-20020a056602073400b007c7687e41bamr163467iox.9.1709149091853;
        Wed, 28 Feb 2024 11:38:11 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id cl10-20020a0566383d0a00b004741d55e66asm7810jab.84.2024.02.28.11.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 11:38:11 -0800 (PST)
Date: Wed, 28 Feb 2024 12:38:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Delevoryas <peter@pjd.dev>
Cc: qemu-devel <qemu-devel@nongnu.org>, suravee.suthikulpanit@amd.com,
 iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [q&a] Status of IOMMU virtualization for nested virtualization
 (userspace PCI drivers in VMs)
Message-ID: <20240228123810.70663da2.alex.williamson@redhat.com>
In-Reply-To: <3D96D76D-85D2-47B5-B4C1-D6F95061D7D6@pjd.dev>
References: <3D96D76D-85D2-47B5-B4C1-D6F95061D7D6@pjd.dev>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Feb 2024 10:29:32 -0800
Peter Delevoryas <peter@pjd.dev> wrote:

> Hey guys,
>=20
> I=E2=80=99m having a little trouble reading between the lines on various
> docs, mailing list threads, KVM presentations, github forks, etc, so
> I figured I=E2=80=99d just ask:
>=20
> What is the status of IOMMU virtualization, like in the case where I
> want a VM guest to have a virtual IOMMU?

It works fine for simply nested assignment scenarios, ie. guest
userspace drivers or nested VMs.
=20
> I found this great presentation from KVM Forum 2021: [1]
>=20
> 1. I=E2=80=99m using -device intel-iommu right now. This has performance
> implications and large DMA transfers hit the vfio_iommu_type1
> dma_entry_limit on the host because of how the mappings are made.

Hugepages for the guest and mappings within the guest should help both
the mapping performance and DMA entry limit.  In general the type1 vfio
IOMMU backend is not optimized for dynamic mapping, so performance-wise
your best bet is still to design the userspace driver for static DMA
buffers.
=20
> 2. -device virtio-iommu is an improvement, but it doesn=E2=80=99t seem
> compatible with -device vfio-pci? I was only able to test this with
> cloud-hypervisor, and it has a better vfio mapping pattern (avoids
> hitting dma_entry_limit).

AFAIK it's just growing pains, it should work but it's working through
bugs.

> 3. -object iommufd [2] I haven=E2=80=99t tried this quite yet, planning t=
o:
> if it=E2=80=99s using iommufd, and I have all the right kernel features i=
n
> the guest and host, I assume it=E2=80=99s implementing the passthrough mo=
de
> that AMD has described in their talk? Because I imagine that would be
> the best solution for me, I=E2=80=99m just having trouble understanding i=
f
> it=E2=80=99s actually related or orthogonal.

For now iommufd provides a similar DMA mapping interface to type1, but
it does remove the DMA entry limit and improves locked page accounting.

To really see a performance improvement relative to dynamic mappings,
you'll need nesting support in the IOMMU, which is under active
development.  From this aspect you will want iommufd since similar
features will not be provided by type1.  Thanks,

Alex

