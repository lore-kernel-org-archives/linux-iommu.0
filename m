Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515A1FA8E6
	for <iommu@lists.linux.dev>; Fri,  3 Jan 2025 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735914704; cv=none; b=Kc+jMv/TiRnJ1/JSsIN9fWJJ0qQg8I6emAf0XaB2LW0qn/s9Kisq0UJuwEfVI8cKITNNKi47AsF7D1tXj2skhmCQEgpkvtvjuVW4Gv3bJ58YYjm2wU4oq66NZ3GSnbygsCR7d2wojLjwD7xPABDbZZcUVf0P1PAYw8cpQaNdd9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735914704; c=relaxed/simple;
	bh=Fe6qFIofTeLLtNfSn6+xkHpbsXHW37Fb7CK/4DFE27I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhRtTz4tYjss1MQeKJ0HdSSontGg3qk6QH5OqziJzocX3EKiJZzjGkM2WPhbjOSPi+dvVKOfriDajGwVLL5617ks2Opo4WjeKull5gpBhFw5ms7+Y8piSzd/ZIuoDJQIEzVXpj2bqZEDN9KO7zrcBIQZqSv7fOUvNKfhxOlMtm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QlpbDDyP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QlpbDDyP"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467a3f1e667so71919361cf.0
        for <iommu@lists.linux.dev>; Fri, 03 Jan 2025 06:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1735914701; x=1736519501; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZz1gAr6AH9VZR9mcSijrSsgtvQXf/lr7rOewXx+J4E=;
        b=QlpbDDyPv2y2dpZw3MIvtHYMo1XEwd8C3JxtawS0ZJ7aw5xow98ihNotmPyOoyOAJq
         Vqgg4tgiJ32TeAajeJCopksnRhO1zDJkTDGfbGvp9yExBuXAgGdMbN6B2POdhTnjlVvZ
         7MxoYm+Uy2gMNN+ErUryBGbeTvEswLGqWZ8V/Qyp70KehCsM6YQ7GIEIrPgD6TLFqSIT
         d1c49YAvGsH03nD1iqtNrvV8TmxYp8MZuchxOgl5qWD6r5Q6GdrwVurDX7LC1h3MVFsS
         1LHtz7jT009XKeu2T1eXbRIuIOoz4kgslrogNTivybVweojNHQsarXUSFdVL6RGTOFUp
         xrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735914701; x=1736519501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZz1gAr6AH9VZR9mcSijrSsgtvQXf/lr7rOewXx+J4E=;
        b=MgmR4/pj7q+6xMNp+YMhcP61zQ9h4tL9rxAHhBdbUaZFf/TZer9tTR+WhGlDIqbsxC
         OrUJGp5y7NbISVRTrpRbUWba8CcvGfeq9BLqPS5VLCOPvKJDW9eerB5bQRKSj17lX1PB
         JK8Z/7DOv4apti84C2rkV5C4Wpykmxpld7s0WdnHl/cPh3zs8Q0xuGhW4UV0mj9d2lW0
         CviotZ8tDBzmBSWnOkVw8ueEAGUxTL5FMBvyv2QEjFHOtI0nB+YkIyW2nM6ejvlggzRx
         1zE5hK0g+XqKCUS2M1L9qsFwQL+wW5LHYZBTi4NaI8gg8oRP7Zp/2tth8qgeV6uCPhWq
         Hmmg==
X-Forwarded-Encrypted: i=1; AJvYcCXev21AqDo4SS6LDVdun+MxD909oCuTq43MOlYixIaXTCdBbkLTjNrj3TmQDzKXJYu5pMCepw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+b5BwKbFAbhpi3Ks0W3fIkviTxlxs+OLNObx+tyu9J/5Lgkhx
	qlno0E+86DBmQBZZ9KWKYXdGHwqFFlCLLWI3Fd5He4Rbsr/dKfOvM0MagwBQ5TY=
X-Gm-Gg: ASbGncsFuZpCD3SrF1WQGw2X9hdyH9thtdMJDp72yN2YTQ/eYWbkxMPFw50LdG7Bo0f
	vwiShXSwLgoYenL0UxVP1+gtF/yJY2PzvRq/GdslWjSVY3CSS0/Z3NTDz/XENTeCvOD/6QXxxpI
	MatP2RJg/virLOLnQJ+nTckyiMed73iIc1q76Py6EznDO46CNx9Ytp5Wr4B2QUb342W5+KnACdd
	y1yWfVqNxQ6yIsw3gQl2sUHdUqwvEdkWIS1TBDTb4lEGaE19tiURnGUI03DCmzEBVtQpFg/eASq
	qtBJ8NDM0OH03GlCvv1GPQMhhRi7NQ==
X-Google-Smtp-Source: AGHT+IGiZCm/3QIaBTSxT82414Bd+tcXwlZF1XMVW0fnnGbWf0zxnCHe0OPTUe/2fE3HXHDT4SXs4g==
X-Received: by 2002:a05:622a:10c:b0:467:68a2:cb55 with SMTP id d75a77b69052e-46a4a8eb7eemr795329811cf.28.1735914701493;
        Fri, 03 Jan 2025 06:31:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e64cf47sm146147721cf.3.2025.01.03.06.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 06:31:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tTiiA-00000000iUS-1wLH;
	Fri, 03 Jan 2025 10:31:38 -0400
Date: Fri, 3 Jan 2025 10:31:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
	quic_bqiang@quicinc.com, kvalo@kernel.org, prestwoj@gmail.com,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci: Create feature to disable MSI
 virtualization
Message-ID: <20250103143138.GC26854@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170014.1583783-1-alex.williamson@redhat.com>
 <20240813163053.GK1985367@ziepe.ca>
 <87r0aspby6.ffs@tglx>
 <03fdfde8dc05ecce1f1edececf0800d8cb919ac1.camel@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03fdfde8dc05ecce1f1edececf0800d8cb919ac1.camel@infradead.org>

On Fri, Dec 13, 2024 at 09:10:30AM +0000, David Woodhouse wrote:

> <fantasy>
> A: The guest OS just hands the device a standard MSI message encoding
> the target guest APIC ID and vector (etc.), and the IOMMU does the
> rest. Nothing 'intercedes' between the guest and the device to mess
> with that MSI message.
 
> /me wakes up...

Well, I share your dream at least. :\

Have the VMM shadow the virtual interrupt remapping tables and assign
it to the phyiscal remapping so that the physical addr/data pair
doesn't change. Driving interrupt routing fully via the remapping HW
and not via MSI interception.

IIRC Alex had a patch series for qemu to capture and rewrite the ath
non-standard MSI locations, so virtualization worries should not block
moving ath to use the device-specific MSI..

Jason
