Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06374351C18
	for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871614; cv=none; b=thfHFCSPOQ2yTJKrGhBBJvW/2VntKjKMBlvbMMdno9DStfKsjHkxX04FiKNxwEdsYlXn7Zn8c1gjjRr6guWfrlzfCKZo4Aby4iG5tiJd48tPN9y1pwRfVRf4MHkImK3W3JdFfzl/aq3TGw/AuqFaUZeldXzied0BO4Nl7BYEKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871614; c=relaxed/simple;
	bh=Mm5cgq431AMp+29aAA5yYiOJktECVQ9HyfYhNIrC+D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfhnBWMTtGQPLxis1vo7AAjl4Vj1pGn+ExY5UCrhnFB/62mOaT0/41OXSeNbcvIuBikxdVX5r9RFJtxj/Vy8HlJIEBZYCJGvB8q/tnKQSziKxP9G2tiJ5OkN7oI7oTfP3OBvzEeu3aC7COcqxgXAI/IzZTk2tWtt5uMHkjoh0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CM9wbNqn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CM9wbNqn"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so29845ad.0
        for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773871612; x=1774476412; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm5cgq431AMp+29aAA5yYiOJktECVQ9HyfYhNIrC+D4=;
        b=CM9wbNqnpz/NdoWhxSckRyhnulg/QRIbyPDCp2BFfRfaizJ2ounlVx4P4qZf08XV/R
         aITHMWdYmrAYVJaqb5VllVrQWXe8tj0LhfnQzcynhHSlZR2bLjDY9xwINC/27114JCt4
         q0D0qTBaCCbf3cu7LSPGfg3ErMrCeqNGQOIwxN/R8I/Jhjh2dAZh0DjT/o+Zgj5PEEyO
         SFEY+J9PerTQqwFquNFf4yVJt5Z0NvN8VSOQCKRcGrHMPbrF7okog1vJaVHQXl9hIK7d
         wzxdiScbZpsPA66Jbr6hJwKj3E9UftuCzgWttjgPcQyQ7tfbOC3js3CAdDwbuGRVqzfP
         I6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773871612; x=1774476412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mm5cgq431AMp+29aAA5yYiOJktECVQ9HyfYhNIrC+D4=;
        b=HwrqOSKOW+k7zCiJh+gH8H+D6jEZaLvoels8NMOY3m7Je8VWr8mJxN+pwiafTHQgXF
         ktgV9G+pLVGTrGND/K0uYWyJx/sE/bIzg4EEJzPUva24NtqHViZzivR/w/rtNu/CxM3L
         eP5u2kDkWU/paTeKPkhj7Jh4Qb0rEhED4Ue1ZSTWwV76zGijXjnsmn1lsgSAKw+zxY6n
         rxI4xlrfqfHezZymzBAwaAXXENn/gnmOO9MNzO3wu+MQeJ7QIt3MpqaqCCCQXLQOOeUH
         jMtt9+YlytrEMoELxILrS7t4OQI+ecwyynlJ3UuZUaSc7w2Xzi++Ok6m/N6iIZSo/p8l
         nqBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU19ey2h4SWX2AfGt7DwkX//685rsJ5ckL9FWnANvC8ZbC4xBOJ7p1ohY2f0jkjhobxtFGIqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzB+RqKZEjO92xwErAuJ2BIogxSGiE1qyH9O1j6mQQg4gTIb29T
	X0E4Fgcokn9KA6IVyYm2NbB7xndDQ0qsCfKlavhHLKLwt2t7b4hbDRLK4GfEoEl6fZjzW5NU6aa
	v5B9Cw9/H
X-Gm-Gg: ATEYQzzeJnbPjxyvrx6bNKQ/soEFSkBaFSB0arM8INWgOvesLjzST5ywJ/lkXNLdyWs
	Jy5RlpM5kBJFwPMl85MAGzFSnYWm/J4NZ3PG9/yZAtwa/tTUFY7Pc8o/qC3GHh+Hion3SYubVg6
	gVMs7UrDbWjkHOdc0OfM/bCRXWSQFrFLf/gUODMaUogcGBA6vzr7sAmZ0DqjC3vRk+Ljxx2xWn3
	E8hkvdVF2QnGjml6sphbdEGZPluUjdowvMdfh/wk//1lNTVSloVpkZk6hWNGw6/YducBAVFWPnL
	GbalH+K9C0anbbJNOKeHFnqRpxeuprsBWzZTkHjVNd1UC5mx8/S+ypLRJ8ZG0EWV39RYIFwY2Il
	MeiTecIW/JR8Y84pL4R0HaL1zrMukoLA4T+UlMJ4OAjHq6hCYkYypYkcjbd7cr4EEpb0piPBOj8
	shN2u7aAr3fkFNgV0zX3ltKORp1nUUag5PeRul0KWjOPF5DP9wlnV/yDgd2DFFnw==
X-Received: by 2002:a17:902:f54b:b0:2ae:4808:bd99 with SMTP id d9443c01a7336-2b077ca07c1mr1353525ad.2.1773871611494;
        Wed, 18 Mar 2026 15:06:51 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e44a42esm37397735ad.33.2026.03.18.15.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:06:50 -0700 (PDT)
Date: Wed, 18 Mar 2026 22:06:48 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, 
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"joro@8bytes.org" <joro@8bytes.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"jgg@nvidia.com" <jgg@nvidia.com>, "rafael@kernel.org" <rafael@kernel.org>, 
	"lenb@kernel.org" <lenb@kernel.org>, "praan@google.com" <praan@google.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Message-ID: <absaKimeI_TXXxuu@google.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB52763AB181F5213FAAB4F4F08C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abr8aS/MDU9aeKu9@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abr8aS/MDU9aeKu9@Asurada-Nvidia>

Hi Nicolin,

On Wed, Mar 18, 2026 at 12:26:33PM -0700, Nicolin Chen wrote:
>On Wed, Mar 18, 2026 at 07:36:20AM +0000, Tian, Kevin wrote:
>> > From: Nicolin Chen <nicolinc@nvidia.com>
>> > Sent: Wednesday, March 18, 2026 3:16 AM
>> >
>> > An ATC invalidation timeout is a fatal error. While the SMMUv3 hardware is
>> > aware of the timeout via a GERROR interrupt, the driver thread issuing the
>> > commands lacks a direct mechanism to verify whether its specific batch was
>> > the cause or not, as polling the CMD_SYNC status doesn't natively return a
>> > failure code, making it very difficult to coordinate per-device recovery.
>> >
>> > Introduce an atc_sync_timeouts bitmap in the cmdq structure to bridge this
>> > gap. When the ISR detects an ATC timeout, set the bit corresponding to the
>> > physical CMDQ index of the faulting CMD_SYNC command.
>> >
>>
>> It's nice to see the ability of allowing sw to identify the faulting sync command
>> upon an ATC timeout! On VT-d it's not feasible when multiple wait descriptors
>> (similar to CMD_SYNC) are in-fly... :/
>
>Actually SMMU doesn't know which device is faulting when CMD_SYNC

VT-d is able to find out the SID of the device for which the device TLB
invalidation timed-out occured by using the SID reported in the
"Invalidation Queue Error Record Register" (VT-d Specs 11.4.9.9).
>follows ATC_INV commands for multiple devices. The commit message
>in PATCH-7 describes this in the end. So Jason suggested to retry
>those ATC_INV commands by bisecting them per-device, which allows
>us to pinpoint which device.

But for a software timeout, something like this would be needed.
>
>Could VT-d do the same?
>
>Nicolin
>

Thanks,
Sami
