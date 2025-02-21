Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D71F4299
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132441; cv=none; b=Fkodxp5FuAgx/8LpzcIdyYORXBfX24vb0CBjFHog/lPumuRSRT7Ru1KZFSRzhFps2U/wEdDQ2KG1IkPPANuIZ6fkRiqd+X4acNXMnVVIJfEgiyXpjzrUBYIQrze+bpvj6ztWXTmWadxN3LJfqS6Qbyel1P/D/FjfAF22hUzF4fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132441; c=relaxed/simple;
	bh=2Nm+C7EXfQilANBV3KPmeUoSajCu1VwQBdXheYtZWRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nf1ygZscWrnTZ6CMLhN/hrc39Ky9gIUFAs4r1Zri7yLg+ayn2DRLrKdAhQEj9Cp7gvaodeR5OGyrWQHwWQZ7tO2OTr79xpBDfyZb32DCpdIGNJI6JiCRwAwHcdFMSf1Q0s9u07DKysXRVQMP+3bC1AFFKV1NuPQzZj+xGO8B90g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OR/3orZZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OR/3orZZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740132437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6foSOg2pfy9gGZuw8NYjJ8ygWH/JG2sfZjN82ttO/gs=;
	b=OR/3orZZhPdEbrNsHTbQ8gEOp/YN5wH0bSF3tCDM19x6nMFFA2uJgPhoStrRJBrxY2WYnT
	uaXvJNQpVHbhdVVQYaZE5VW4L5ZxjaBBcXUbuGBmWDnnDzjnJ3RUZk/YlbPC6eCJhgaur6
	h9QDQzxeLugbbDKupEieyvCIEoNzDTs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-opd1YWcnPgGPd1yp6icX4A-1; Fri, 21 Feb 2025 05:07:16 -0500
X-MC-Unique: opd1YWcnPgGPd1yp6icX4A-1
X-Mimecast-MFC-AGG-ID: opd1YWcnPgGPd1yp6icX4A_1740132436
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e48a052ad6so40649156d6.2
        for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 02:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740132436; x=1740737236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6foSOg2pfy9gGZuw8NYjJ8ygWH/JG2sfZjN82ttO/gs=;
        b=E1QJM6yh1WuIeQsfT4MvPToixDzOTU6b/QgexYsR0DZKtfiIuY9kQcFXzoFJpU52gt
         sCp9DW9nHIxfeAeJhlQbk4zWYNMttJMHRmUMUP9Advhyzg3Sz3pOFTHRagXmLIa/vZUB
         QcPp97hrKJLi47frLRawQd6xTXvgZPvXrDdHlGCfflCxHvnLwVJKa0o3A9sU37uzhuGt
         BBua9tUP/KZFt8Xk9UkY8lsKXHBOkC1Ut2AIPbSkaWghf3Iev/9VsV971ObglLxJ02Lr
         xjy4gGKwqrsi3+r9OgWd5n9gMMRCel2II2I1nOmftgWg9QHgqzva8wgt9tLKqKLhI0kG
         Gcbg==
X-Forwarded-Encrypted: i=1; AJvYcCViQHMKhv71MlEKT32geOrbK8cHsQ5P8ThaoqwsM7gzsfy4BR3Yfm1blafY1O8pXaTcdmLuww==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4zuwn/Yvutr99tW4ZfLPxKDGE1vtZg9gqlzcYCreXSkI/B4EM
	N/O/fZikmuje1r1BAYJrXPhQw6uJSJxq73Z2qDMlLI7ghZm9EMgYBWhzIUb3OPw/sS3hohWIld/
	L6oMHO0hYufnXFpQ0AkTppAsJR8dd64Fgls5AANMFdsMQvo3aI5nJN3tIYM7p
X-Gm-Gg: ASbGnctgsuJkUEKWbNhpku/XCkGR4QBqVhRVz+pJ/Kex36r7Yx8+24umxue7LmbEiZL
	Re0wM4Vg/vtqhH0W9yATxNfLCVjU6xVyA0wOmsqx7uQEx2bPOIEIhRkxyTPBXwRECdWOn8lw7+V
	sOfm2c95up0oU50NBH2FClupG+EFpvJKQCMhJRG2gfXvMDZhC20wFDMszAiLLnjF6ttEed++Dz2
	AkoMQDNVSXnEBk/zkzY25TyoMdP16Cy96lrZa0fcV7rf+G1AZ71G2+B/JeWBgiSQyJCV27vttCP
	485ZJo6bmnINU8zJFTYA6c9roJHJMGAmc7gyIdYumuVA
X-Received: by 2002:ad4:5e8a:0:b0:6e4:4484:f34c with SMTP id 6a1803df08f44-6e6b01a7767mr24115046d6.35.1740132435905;
        Fri, 21 Feb 2025 02:07:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZcNq29psfWNP7XvrBCeWRpVFeJgLe3D6ybymnRaWLd185tqdKS4nXeiwUxEMeLqwQ4vlSOw==
X-Received: by 2002:ad4:5e8a:0:b0:6e4:4484:f34c with SMTP id 6a1803df08f44-6e6b01a7767mr24114696d6.35.1740132435531;
        Fri, 21 Feb 2025 02:07:15 -0800 (PST)
Received: from localhost (ip70-163-223-251.ph.ph.cox.net. [70.163.223.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e6a11624e0sm20637396d6.39.2025.02.21.02.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 02:07:14 -0800 (PST)
Date: Fri, 21 Feb 2025 03:07:13 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Subject: Re: Question on context setup for passthrough
Message-ID: <x7d3pvynvglmsbst46n6affvryb3d53cifi2nlrymmbdpu5bgo@2fdbi6dlzklw>
References: <rz4kc2zxi4fritsbmjsa3ekqncguvnmeir5se3fhu7pzhtgipk@2u6ps3q3gsqz>
 <75f4867f-99b9-4ba9-abf4-f0dc29d08fca@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <75f4867f-99b9-4ba9-abf4-f0dc29d08fca@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6rBHx3Iyoivp96W4trdUf6QlHUbKj3ymrqbbTi6hfig_1740132436
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 21, 2025 at 04:40:42PM +0800, Baolu Lu wrote:
> On 2025/2/21 15:16, Jerry Snitselaar wrote:
> > Hi Baolu,
> 
> Hi Jerry,
> 
> > 
> > In context_setup_pass_through_cb there is a check that bails out
> > if dev != &pdev->dev which doesn't exist in the code that sets up the
> > context entries in the dma domain case. Is there a reason this check is
> > done in the passthrough case?
> 
> The check "dev != &pdev->dev" was added to prevent setting a context for
> a different device that has its own probe path.
> 
> > I've been looking at an issue where a vm is running with an
> > intel-iommu device, and has a pcie-to-pci bridge with a device behind
> > it. When running with this commit, and defaulting to passthrough it
> > gets a DMAR fault for the present bit not being set in the context
> > entry when the device is coming up, and the rid for the fault is the
> > rid the bridge will use for transactions coming from the secondary bus.
> > Without that check the context entry gets set up for that rid, and
> > it doesn't get the DMAR fault.
> 
> This appears to be a bug. Do you have a fix, or can you tell me the
> process I can use to reproduce this issue with a local setup?
> 
> Thanks,
> baolu
> 

This is the qemu command I've been running that is stripped down from the command in the original report:

/usr/libexec/qemu-kvm \
    -name guest=test \
    -machine q35,kernel-irqchip=split \
    -cpu 'Icelake-Server-v2',+kvm_pv_unhalt \
    -m size=4194304k \
    -smp 4,sockets=2,dies=1,clusters=1,cores=2,threads=1 \
    -nodefaults \
    -device '{"id": "pcie-root-port-0", "driver": "pcie-root-port", "multifunction": true, "bus": "pcie.0", "addr": "0x2", "chassis": 1}' \
    -device '{"id": "pcie-pci-bridge-0", "driver": "pcie-pci-bridge", "addr": "0x0", "bus": "pcie-root-port-0"}' \
    -device '{"driver": "intel-iommu", "intremap": "on", "device-iotlb": true, "eim": "on"}' \
    -blockdev '{"driver":"file","filename":"/home/jsnitsel/storage/CentOS-Stream-GenericCloud-9-latest.x86_64.qcow2","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}' \
    -blockdev '{"node-name":"libvirt-1-format","read-only":false,"driver":"qcow2","file":"libvirt-1-storage","backing":null}' \
    -device '{"driver":"virtio-blk-pci","bus":"pcie-pci-bridge-0","addr":"0x1","drive":"libvirt-1-format","id":"virtio-disk0", "bootindex":0, "disable-legacy": "on", "disable-modern": false, "iommu_platform": true}' \
    -nographic \
    -rtc base=utc,clock=host,driftfix=slew \
    -boot order=cdn,strict=off \
    -enable-kvm \
    -serial stdio \
    -net user,hostfwd=tcp::10022-:22 \
    -net nic \
    -msg timestamp=on


With the above and 6.14-rc3 I get:

2025-02-21T10:04:34.182950Z qemu-kvm: vtd_iommu_translate: detected translation failure (dev=02:00:00, iova=0x1091af002)
2025-02-21T10:04:34.182967Z qemu-kvm: New fault is not recorded due to compression of faults
[    1.151941] DMAR: DRHD: handling fault status reg 2
[    1.152212] DMAR: [DMA Read NO_PASID] Request device [02:00.0] fault addr 0x1091af000 [fault reason 0x02] Present bit in context entry is clear

The qemu is based on 9.1.0. The important bit is that there is the pcie-pci-bridge, and the device behind it has an addr other than 0x0.

