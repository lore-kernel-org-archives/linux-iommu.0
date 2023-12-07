Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC93C433B9
	for <iommu@lists.linux.dev>; Thu,  7 Dec 2023 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CJZJUAX4"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-423c28db22eso16432021cf.1
        for <iommu@lists.linux.dev>; Thu, 07 Dec 2023 09:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701969463; x=1702574263; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfZC4BeoCbD48i78H7pAT4Ky0OQzCC++X2uJD5yU/sg=;
        b=CJZJUAX435xfd/3c3/ucSJ3oX0s/a0r22pb/ZnUUP6evvB7SBAQ5wVIeud6FfC7LpK
         q7gGJakp8pLALDCTS2WZoE8YoDpD8h6Iac5UbtRO31nPrspc4W/dqwSqR6zObWZxzzWP
         +eAgpBqj78RkG8DIXUWQlWLnLx041vR3X66sw+t+0qOUz/tAOxoWnNLk0MB2KKLJ9VWK
         ahEeAVL9RXzp5gBtpqKgUSsjaBJBwRIAAg0U7rUuL1Wvcw+0gTroXVNjKlSW3/3lPP5H
         ZwVryEItxNeNMu+G9PZL5dZKCAVIvwXyb0Ne0eTwq9u8j6MrUZ11JbVUHDx6WI4DQmsv
         OHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969463; x=1702574263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfZC4BeoCbD48i78H7pAT4Ky0OQzCC++X2uJD5yU/sg=;
        b=iGA2P0im8sRW8KkXeJAyUVozJxXTFvIGerBSBVmFFgPMmBdOaLYz9r8J6PVRm6yN/5
         VqNbdvTX0XXfpAqz/iOrtUv8YmQjU/eW/l9v0108OfyeFwoSaKNYi7BaEg62p3w7jjZS
         JLvZsrT+3bxFsVAstJfojDWbVCuTVnUdcABwXWfjqK5JBQ74JTrmwYJY7Xt5WI7XXiJ+
         GNLxgAw99kAJvgSKgpl0JKxVDDG6jPdDLc05WBzBBw0ae/A52FZZosV2H2TPIWpwOpbX
         Ni9S0SzkFCCR1oCBqMlcah6bPTIr9llHiCrTJxAkjFnjk/yvA6O2QSqwb+v4v4QIf9H8
         YxmQ==
X-Gm-Message-State: AOJu0Yz2X01sLqBuWlgjWFo9NK3prwzX4mlpJBiqJQ08grJE46rarafL
	+6PkWU0RhT4DGaEuSzh1MzkyHg==
X-Google-Smtp-Source: AGHT+IFZla2NtPfquQTzU6hdOuHOkG1umIFAlj7i5uyx6faPcX4R7PtWVD+lIF+qCRz3hijffJ+Kvg==
X-Received: by 2002:ac8:4e83:0:b0:423:e097:3b14 with SMTP id 3-20020ac84e83000000b00423e0973b14mr6734973qtp.10.1701969463718;
        Thu, 07 Dec 2023 09:17:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id n2-20020a0cec42000000b0067a10672b80sm66393qvq.48.2023.12.07.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:17:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rBI0M-00C1FU-8T;
	Thu, 07 Dec 2023 13:17:42 -0400
Date: Thu, 7 Dec 2023 13:17:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joel Granados <j.granados@samsung.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20231207171742.GU1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <CGME20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7@eucas1p2.samsung.com>
 <20231207163410.ap3w4faii6wkgwed@localhost>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207163410.ap3w4faii6wkgwed@localhost>

On Thu, Dec 07, 2023 at 05:34:10PM +0100, Joel Granados wrote:
> > @@ -58,6 +255,8 @@ static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
> >  	WARN_ON(!list_empty(&fault->deliver));
> >  	WARN_ON(!list_empty(&fault->response));
> >  
> > +	fput(fault->fault_file);
> > +	put_unused_fd(fault->fault_fd);

> I have resolved this in a naive way by just not calling the
> put_unused_fd function.

That is correct.

put_unused_fd() should only be called on error paths prior to the
syscall return.

The design of a FD must follow this pattern

 syscall():
   fdno = get_unused_fd_flags(O_CLOEXEC);
   filep = [..]
 
   // syscall MUST succeed after this statement:
   fd_install(fdno, filep);
   return 0;

  err:
    put_unused_fd(fdno)
    return -ERRNO

Also the refcounting looks a little strange, the filep reference is
consumed by fd_install, so what is that fput pairing with in fault_free?

Jason
