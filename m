Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7654E19C556
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776986871; cv=none; b=SQ6XiMut/TiJpsPh7CKmT9ZKqw8Vp+iCGm9aMxwunGpBo4HMUD8WbTZrXovbNmZ5ecP9hz/nA2LuKjytQ/5oUazQ7FlymK36VfIwQdkbhBxPypwxpcBzRfOskEV4JpcVQ1ArfZ8YURoNW2dxmKabgZckY65Mk8IkRpHWfDLvLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776986871; c=relaxed/simple;
	bh=gCwmX1OtHkLJhZqpnRYlpSdpxrI4jzQ0Eg7EJB7J8GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifTEaU7uxz541FKA7xYd07tzzb8l+Ld30cl8s2d85VAsGmm6W9x69LY7PSux+PNI3nRY4MuKEX5BfPGOLdL1y/uZXfUjT1NbRQw3aBvoPaSCWdD33nAUP4vf/xgzpLJSGSrmDKEjzwjSUbjO4U2PAgnY+KxMSVuaJiQeiNTbRSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P2nZaEO6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2nZaEO6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b243198058so187615ad.1
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 16:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776986870; x=1777591670; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lt0LRXP7f5oacTu2NcOl/7iPlzf9+apNICsUQAZ1DMY=;
        b=P2nZaEO6+CcubEqnhbON5SJr6hypqk1LmBUaFOySkt93mQIc3vWF7jmDTPJpH8VAVr
         w6JAgxzjrHJlOLPQWsmxbbHo9FRW4LdUcGJyE/kK4bLQxtSX95hvcJW8GTn76BfljXQS
         HxcChPy6b7q83nxyRGIlioB9R7eQRiQxrnZcXv8eO6aqHc+jbbom+BK9CATladJvls+g
         9w+Q9Y1aOIA4Fs78Kzv/wwrDTtDTiPuyh6n+OfrqaXVAPxkKYFAJsCglpOk0cBsR7QAK
         7Oc+LMyuX3sqxZ2miNp1Xwe9WKOfyqZkTQYGG3SwP1V6oBeHhz26gsy8Y55F7WH/Y19T
         k3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776986870; x=1777591670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lt0LRXP7f5oacTu2NcOl/7iPlzf9+apNICsUQAZ1DMY=;
        b=nGgmSCv3Q4A/O4HO4WIvCE3mHbBnM3VrsY+IUdjWeFn5utw04xaykT1lU7TTkmMJjO
         T9JbKWCfXCtYfLWkta48Awpjsbcr29f8gM0dgs4zTihemBJNWfqLi/ccw+PvAZm+2emL
         w/9Hv+Nd/Ky7QJThCUggUEeGBiWpH15ZY1sG01C+6iFVt7PDezbjnSFtr4CBh1RWfTag
         h4Sxlt1Uv0kf6T6jzpXlL51QUFYtYERRDLDkGunYJHwjfvosUN41JwlD3WlazI2yM6nr
         8WIiAscIorqUY+S+k3OdG5lqBjeaLz+1QhJf/z5rDAcRgzYwMvOVHiPf8FOk5rQEAibw
         bcyA==
X-Forwarded-Encrypted: i=1; AFNElJ8KpCQAIWF2L8WbfEw6uOEYPPOOZXnXZ80ZjO5lrsCeAoPOVk9bwJpLqJzcOCkBDj8npdBSQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBK0Z/pXyZz5J+EQTi7D/+d9FzD/OD9HDdrcDRQWFLRM68PC6v
	OTKkBiox6cz5ye4zuprR2fxTY82RJ15wiNcZkawrr4tV8GlUCs9jJjh06SZ81up9kg==
X-Gm-Gg: AeBDies+PpUSFeF/p5DYwbJo5Gy65f/slf779mz6m7cMJlsl3/bnKRWg7ac5i5MzaUN
	HjT8hvpxCG/vf0V2z456YbDuNlcSNC5ty+dDFhqFcy/KXzVOP+a47eGrW4euogHrm5WnCF4uJ/u
	6fi5bmXXamcNZnFcgKNI/sQO14k0ps9ij4uTyiyrRARZ36tA4mgkqpw5mA8Vg4LxjlAo2c+S73d
	48mTWEnFadU938DLXWApVCxd52F+iVLbpDbhBh5XfyPGQ3XuhhnWXyhxFj1K94S46XNLst/Fh0m
	pZCEayeaaKQ1PBbMphQKIJyHDkArYCbmyThY+Kt+C+17+d8QuFaAoYitseUDYptUZr5goowEPUj
	eBnJ8AtlFRkTw21PNRcAhLaXI2sV1nJEGuAtvbG7gPFm1gXOh0avI+YPH5wJRertHRhLcN6AvSr
	OJ8PgbCPtR+WXlMcFfOfbcnw899/ThTeNc9DApBhz4KEKVZryFjhKv+dJ89BPYO5j0eRTvNEhdL
	2tUy6UqonQ=
X-Received: by 2002:a17:902:cf01:b0:2b0:5e19:1862 with SMTP id d9443c01a7336-2b603f4969amr20900125ad.5.1776986869309;
        Thu, 23 Apr 2026 16:27:49 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f9cabfsm18153636a12.9.2026.04.23.16.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 16:27:48 -0700 (PDT)
Date: Thu, 23 Apr 2026 23:27:46 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are
 in immutable singleton IOMMU groups
Message-ID: <aeqpJ7BeBtzoPIx4@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-9-dmatlack@google.com>
 <CALzav=dGpHEnEjyp8qc50iZrGeKJ47vjLvwtvkLCyNzOMJhozw@mail.gmail.com>
 <20260423225253.GA3444440@nvidia.com>
 <CALzav=fraXLgGs-XMc-=whMPhMbS99twFskGtV5Eo=UQ9mU5Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=fraXLgGs-XMc-=whMPhMbS99twFskGtV5Eo=UQ9mU5Fg@mail.gmail.com>

On Thu, Apr 23, 2026 at 04:09:01PM -0700, David Matlack wrote:
>On Thu, Apr 23, 2026 at 3:53 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Thu, Apr 23, 2026 at 03:10:55PM -0700, David Matlack wrote:
>> > On Thu, Apr 23, 2026 at 2:23 PM David Matlack <dmatlack@google.com> wrote:
>> > >
>> > > Restrict support for preserving PCI devices across Live Update to
>> > > devices in immutable singleton IOMMU groups. A device's group is
>> > > considered immutable if all bridges upstream from the device up to the
>> > > root port have the required ACS features enabled.
>> > >
>> > > Since ACS flags are inherited across a Live Update for preserved devices
>> > > and all the way up to the root port, the preserved device should be in a
>> > > singleton IOMMU group after kexec in the new kernel.
>> > >
>> > > This change should still permit all the current use-cases for PCI device
>> > > preservation across Live Update, since it is intended to be used in
>> > > Cloud enviroments which should have the required ACS features enabled
>> > > for virtualization purposes.
>> > >
>> > > If a device is part of a multi-device IOMMU group, preserving it will
>> > > now fail with an error. This restriction may be lifted in the future if
>> > > support for preserving multi-device groups is desired.
>> > >
>> > > Signed-off-by: David Matlack <dmatlack@google.com>
>> >
>> > Jason, do you think requiring singleton iommu groups is still
>> > necessary/useful now that this series preserves ACS flags on preserved
>> > devices and upstream bridges?
>>
>> I have forgotten why we introduced that? There are alot of funky
>> things about iommu groups that might be important upon restoration..
>
>You had originally suggested it in this thread:
>
>  https://lore.kernel.org/kvm/20260301192236.GQ5933@nvidia.com/
>
>> Like if you preserve one group member but not the other what do you ?
>
>Yeah I imagine there could be some tricky cases there...
>
>I wonder if PCI core is the right layer to enforce this. Maybe this
>fits better into Sami's IOMMU core series since that is where all
>those tricky cases will be (I imagine?).

+1

Also I think this should probably be checked by iommufd and invoked
through vfio cdev. Basically when vfio cdev calls into iommufd to
preserve IOMMU specific aspects of device (PASID table etc), iommufd can
check this and return error.
>
>> Even if you have ACS flags there are cases where groups are still
>> aliasing DMA..
>
>Hm, if a DMA alias can be created after boot time enumeration even
>with the REQ_ACS_FLAGS check, then
>pci_device_group_immutable_singleton() is not really immutable.
>
>
>
>> Frankly, multi-device iommu groups don't even work fully last time we
>> tried to use them in a VMM. So I think I would not expect them to ever
>> intersect with live update. Blocking something tricky you can't test
>> does seem like a reasonable thing.
