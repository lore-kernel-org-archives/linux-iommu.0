Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF163CF
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737468358; cv=none; b=m0aBTWeEePo5WTmXJdeLc1XBvtdFC6b9Ue9qTBpXZ9NJgzRngTOL6XY6iK904D/vltVSiUOdEvyeiu81f5T0rSFlOLnBWd/VQaIxX0rOjlED75A+K7csKZ55RnY3wjTcGOpiFkmfjtwufLRCjYHX7w6mha/5lqk7HHIkfFcfx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737468358; c=relaxed/simple;
	bh=Dkwx9tgiYKi66sIwegQ0qrKst+TwdTwAexE5ayIcojk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkWq7B+PJ9vCQeeaVjFsIRoX6JgDKYjDJR2LE91XYxripPtqXnaavBM4tK1JDQFkQlF+nHR/ShFLOncnh6PmC7JlC+piUvkOB0nRumhNZs4YJXyJTsBaTAdITL8yUh3A4bAEbVrg0VWx8v8fjF7RrqPNEs+B1kTVKTgk/g1SJtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ClA1cHfJ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ClA1cHfJ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6ed0de64aso511062985a.0
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 06:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737468355; x=1738073155; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dkwx9tgiYKi66sIwegQ0qrKst+TwdTwAexE5ayIcojk=;
        b=ClA1cHfJiLKJ27H46gc52zJ78UmiQCJH58bfwZQxl5C+vJiwuBNyFKRAfbDow0gsq1
         vl9m/M5DngVs41Cs1CIGbn9jqdXDDZbsH0P6HRApsIZ9U9TrDMJKPppcZWFg6i9sE9L6
         Wlx3c2bX+MViL7OxI2kRoleVPUPB4fOFgjapSZKYpOyZbXagTwVKDyUYbM8kMdc+8bkJ
         wlCaP316hIoPhI1cNPa8q3BZMGE+FAH1Tfd/yQGNItHaySG0o+ViCcCqTdvIZFBiR5+N
         92vjZdF/PZefndW27Y6rwV8eaZ69A0Z8s01ErHzc+y3jsgrWPDwN9/8Btf48QdmMBTwt
         ibEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737468355; x=1738073155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dkwx9tgiYKi66sIwegQ0qrKst+TwdTwAexE5ayIcojk=;
        b=JR0iTdVmd6NtFWEl893dxP6bNRve6flB5rPvciSye0bpFLsxl0+dwaBr8krAUOWhv6
         vTnkT7dxKjwSy0zo7p5EIfSuOzC+ux3jFaOKd2TRqn8nkxjKaDOfS9rQcSkWeoy9ZKsh
         GYivxmroo6qH0Qdr4r0DaoDEbneAEZU5/cIrY1e0pp/A3loeoXaf1ikk4zv+7eLImVBJ
         UyudW3cAKrGGlsO1g4NkdNAIqYNfNZ/DowFn/yUlaQ9QV8k7Xtkpyq/sZAPF9lKSOpNB
         npMy8LzMALw/XFfWSrFFQliam0DlO1JS5JuyQpJY8wqw7thchV3Nk7IZ/anhbUPMDqpT
         /3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe4K/SF9bNGoPng5u5k734sOXhcqa/htT/e0AkbZK07B5j5PPcz59EVSrPvFGryhuy8sz6lA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7EQt8AmXlUEbs/u004bf7xQAS9CdoO8CP4F2ZqrHvnm2Ma5Le
	5WV1aX3sxfn8aRVjnDkaNFe+4DJo3B8GDIp9YL2bsUL3CtpzGbiwqydH6ydlpyM=
X-Gm-Gg: ASbGnctuTvqZwV7cRN2iIUkNkoJ7jlpTsvvsKjt5O59zcc0ZALwiaGGHbd2PjrOaksQ
	OLgky0m8QZ+jjuUpQKcXx5MRV5bW6uwGVPwdulKBCOzNYyR+Sab3A5Jw7lckOtH7e4SerKixxv6
	fwuFBGq3V0wePTe2EewS7nJDtXpiTgpsquVkvBpl0j2DdOgEm5MZjus7haYhsPsy/3AzjrfDUFs
	BmAEHakjFQGJIr3uP5xokXSOzyTcZfVBMxYDy/Am8lQ5DbfC/MgmIJDv+ajuUyA6OUtWXPeH3GX
	N9AciRodHKf//1X6nhmc3jreNCeq73bOPTxDKFpHQv0=
X-Google-Smtp-Source: AGHT+IE++V3SWyktrc2J5Kp/jb4mq59Zv75AygSHVmfiYTqXVgZXaSVeUCP5iLae79m0enPmM5f/VQ==
X-Received: by 2002:a05:620a:15b:b0:7be:7fda:69d2 with SMTP id af79cd13be357-7be7fda6a8dmr587627785a.15.1737468355227;
        Tue, 21 Jan 2025 06:05:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614d9af2sm559168685a.77.2025.01.21.06.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:05:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1taEt7-00000003fgW-39nj;
	Tue, 21 Jan 2025 10:05:53 -0400
Date: Tue, 21 Jan 2025 10:05:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Wencheng Yang <east.moutain.yang@gmail.com>
Cc: alex.williamson@redhat.com, iommu@lists.linux.dev, joro@8bytes.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	will@kernel.org
Subject: Re: [PATCH v3 1/3] uapi/linux/vfio:Add VFIO_DMA_MAP_FLAG_MMIO flag
Message-ID: <20250121140553.GP674319@ziepe.ca>
References: <CALrP2iW11zHNVWCz3JXjPHxyJ=j3FsVdTGetMoxQvmNZo2X_yQ@mail.gmail.com>
 <20250121112836.525046-1-east.moutain.yang@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121112836.525046-1-east.moutain.yang@gmail.com>

On Tue, Jan 21, 2025 at 07:28:34PM +0800, Wencheng Yang wrote:
> The flag will be used by VFIO to map DMA for device MMIO on IOMMU page table.

Definitely not, the kernel needs to know and protect the memory type
itself. Userspace cannot be allowed to override things

Jason
