Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E611A30DEA1
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283090; cv=none; b=tZey76A502JsZNJtt7Frja1OAk1jrxTuZK1Ux3GLxOjMN6POA/ZCbisdi8vztDFIIlVBqV0AfnvxJVhjPuoQrNgSAkDBHVVGgqhqAXXZmGuUu13Z0rYnnDqerjMyrtLHbrRdB5BWwVe+z1c1f35JUiy4l7gPaCqJrGeyKvi/qmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283090; c=relaxed/simple;
	bh=z76f63pK7iULjhkDPA2cDB1JEhtZUbriGGo8ro5LyIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUOPBu9EFPVJj9wB2vqG5CY9DSNcEf9nFDIEvOUWTRk+NWwgXQYrWVIsrJCGBH9u+pK/JMZrCgTam5TcurL/4/6f28VMFrqbq0iNaz9cCmjMDrV6u1fFTUsreCIpAKef8JatZ5/UDQ13J7lTfTlCHF/kBrCA1agBXJGlWlqmHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bNdAv/Te; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bNdAv/Te"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b7997a43ceso23465711cf.1
        for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 04:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758283088; x=1758887888; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XqkzJ715IFhAdPqz34JG4QrSrgL1I3NolvpeVSTSpSM=;
        b=bNdAv/TeLHJQyMS/GIevAWNb+f3zkbGONli8QkAGD0f7nV38e+Y+sABF8DwAP6JqOB
         lSCE8GS17GZWawEGwETavB2vBAOCAIYldUzJPkarSU8wkkQq62FGOS6/MePIcFUhUWpq
         jq/D6qyGDMRRJlWptyWt8ydh5GhIMJIJClBCCeRW9ZukCKzL81/GEBi+QM1U11/wKbC0
         P4z6hS+4+JMM5lIpyLR3ca7nfH1eHy85LXm54v+bjYCFakvZB5CvIIBMubREcLUIGorE
         NcMInNeJu17Zp0N6hsWUZKfENic5aqIpXu+0kCrv/+dXX8ypAEiRVew68HgYncrzh5tH
         etSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758283088; x=1758887888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqkzJ715IFhAdPqz34JG4QrSrgL1I3NolvpeVSTSpSM=;
        b=jFJAGG0yGGbWlSt7HCnm7KPMGuSH1P5BMMa8eLaZXj7KsVcD6peD6U9RmeYAeF6Cwk
         ZWzSV+N9SfVavjz/qP86O2hNURS+qXSbQm+qxi7Fp0azIihxkqrn+k0yQxHVFXfcQxzv
         9cvPYpB3SSLR+KSSmqHJ1HbXdMUnM6lICWdsoKhxvzzBz0IQYywpPPuCfrr6KQCHV821
         4z1eTH6SRcCgbhFqyG6bMKkMYIe0VvtB14HXM4mmdl1qE4oDxZ747s/gI4DVEuY5V4h4
         oZKX34dbPQ4Ps656JK4auJbcCiIUh6Z8NfRgyPO3CIbSz3q+swnOyNSLh0yvjLIkM7hE
         Kq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4lyd8XDzwTmrYnHxlklW0ohylRF3gZjfB5YgQJVRciJ/XadcT+uq/n3VhaUrIUKdNPQQwNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpmiNUAhpP55w9zkllgk3mp2akhBVf7INH2KwdHw6vjLUI3h1i
	uhYBfZL4Phf7SYJY8/I8Fiv7kkDo2V5XQAR1C5uJDCrmYIiJOTT961TfUtLS22ny99s=
X-Gm-Gg: ASbGncuyrQzETTU/KRODM/eR8agD03LGvSOhurBC8G32+5zZzUHwyea+WKBOUNsVuiL
	gqmP503KDVAjhfWzN/Nb5juhUEMpS0dvSuNMMJW4K1o9r6Ur37FwKyeL9jejKQioY0WJWRmNnZ6
	YZwXTK1iY0AkpF05TNoyUzq6r1VPMdbpTyh1nmNQKvYPKnX2Y7QNkAns7wkFZiBPe+rgK+pqBF2
	nQ3YnCtyS7JKj8r7+la4wLhqsG+LKVS38aPM8WUYgaM7p5PETNVUTyCcfaS8JAYqmIS9QS98jj/
	NCmHVDHQF9U+w5tim30shb5UkiUfQXKzMqOiUZMT4FqclNeyd8tUq/SGFqfpu1PjCKjq+9Wu
X-Google-Smtp-Source: AGHT+IHAUUCTifYO3tvHTIggD1bty3WA1tAmCInvXz11D2JOt+J25vVYjGygxn7PDvPC0VZaaS2K+Q==
X-Received: by 2002:ac8:594d:0:b0:4b2:cf75:bf10 with SMTP id d75a77b69052e-4c06cbe95ebmr27476741cf.17.1758283087738;
        Fri, 19 Sep 2025 04:58:07 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8363198ad41sm325729185a.46.2025.09.19.04.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 04:58:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzZkb-000000097c5-40qZ;
	Fri, 19 Sep 2025 08:58:05 -0300
Date: Fri, 19 Sep 2025 08:58:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Keith Busch <kbusch@kernel.org>, Alex Mastro <amastro@fb.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, David Reiss <dreiss@meta.com>,
	Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
	Li Zhe <lizhe.67@bytedance.com>, Mahmoud Adam <mngyadam@amazon.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	Will Deacon <will@kernel.org>, Yunxiang Li <Yunxiang.Li@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [TECH TOPIC] vfio, iommufd: Enabling user space drivers to vend
 more granular access to client processes
Message-ID: <20250919115805.GU1326709@ziepe.ca>
References: <20250918214425.2677057-1-amastro@fb.com>
 <20250918225739.GS1326709@ziepe.ca>
 <aMyUxqSEBHeHAPIn@kbusch-mbp>
 <BN9PR11MB5276D7D2BF13374EEA2C788F8C11A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D7D2BF13374EEA2C788F8C11A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Sep 19, 2025 at 07:00:04AM +0000, Tian, Kevin wrote:
> memory of other clients and the USD... there is no hw isolation 
> within a partitioned IOAS unless the device supports PASID then 
> each client can be associated to its own IOAS space.

If the device does support pasid then both of the suggestions make
a lot more security sense..

Jsaon
