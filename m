Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982664D17BF
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636919; cv=none; b=CpMZMJAKy0o0ppE93orDGFEox3YbgIkEO57H+OHfzsDUjGiPhb8V7fw0IxOCmRu6vexBQgGEw/KzC+Oo+SQ/53I827ykpyCfEa70qeFu1/CJf/QOAhZ6mgzbM9JPxvUKF35iDI33f2gHPACPLBSTqtTuW2oxkNU4nmF3d+7oImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636919; c=relaxed/simple;
	bh=0nWeG7gLZ/H7cWQa/8TVyUSe9M/rW/4Yls/RoHMrSnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfXNoEUh4MIIqE5v9qAAVZNeCEtx0hk2QHQnDhqfoRVd84k0nw/sVlZZ+Ht+Z4rybACNfqwdwNbHNl9VhDmmtYaEU0FSy+Q11F9RM4a3V4Y0BLP/lojZuevfyLuq6ZXUAMn4IrNN8bAzv6e7of1WG/fSUHhD/ggp+eeu/W4ZCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HAeUAGV2; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HAeUAGV2"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b4f2d90c4so6096eec.2
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 16:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790636916; x=1791241716; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=77Ly/kE6ea0uAMR6LixnKC4rocy66Cjich0gHdqD2Co=;
        b=HAeUAGV2oWbaGCBvxP0a0vrPMwiXQksarFptTXXXst0tgzSx1XFVVRpYSNIZBoaKTG
         vs6SjCN+blJ3e7TeN6dirN8fk0mDTdOHMZQZQcfByDJiWiM5gY3bDiKtMsOw4dxue4Ds
         PM46tahyrltUNz/fOCmjVgh9lN1a988nHCeNGdM55n8yaLjeSTXqShL/8zU58/JjnNDP
         5Z461Kie4mZiqiq09M4kMqVZiTHijEo4kH3wy9ESvO1FRVfMB4Mkw2xwEMjpLN7HaxKt
         X0rXqjiRFfmA9NwLnLQXMWnvtuYmouwDZttSCq7CIjNtF0ULgZpL1y+TIE2bvIPyXSxj
         WsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790636916; x=1791241716;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=77Ly/kE6ea0uAMR6LixnKC4rocy66Cjich0gHdqD2Co=;
        b=OmtH3o63bUQA7TVuv4lzxsIcBZQP9yLyiZ5cOBQ/czcIq/fCtK6n2yj9fNtsfY2Ezh
         hQU0f7ePpX3YpzJSkAjxV0yEYLtvMl2PWGLmc9hi8mFJyhF3UuzYQiRhWtm4JgtLSBKp
         DXBBK/Ok1VHP4IXD73NCFQOiyEMuJP40iXCZBAyghjQk8tHKG8HSOOYcrXMutYevOSyu
         3P1Wgos6gZdyCPECygi/LO5Is3jlm0dIJx2o7vtl4d+XiuXNXSMEObsIiZueEsAyFM46
         687p9PWLkUVwwgZvGcFYM7jWbFBJdO4frVlWhLQs9H2/HEFhL5ke62MKIntD4KLRRP+W
         sffw==
X-Forwarded-Encrypted: i=1; AKwUvByIRkKuE8VBjiWQcdlWCxz3JPFE3JOFhSjq3ErkZOtNlFp8SI6D7f0AeTi0vcQnovE5vudl6g==@lists.linux.dev
X-Gm-Message-State: AFq9FYKFskmsymdb07D2+GWN3uVJDkImgpj80qCi2kzWyi/+PvFLOT12
	+3Jr83/xG8iLzSN3h+3WCuwWtvxzFBuEMYotsk67s+zxqEdW5T7FgoCshQxPFrWptyI=
X-Gm-Gg: AYBFou3pgm0Hj1eINrrNZ/4QeuRujK8FIuhilPwknbV7drrV1wYmMlzM0GHeUO+Ms96
	UbAdXdIjcygelmiz4csyCaDOeq5h9sRbMoOqHfKmk+ME0IWjveJpJf38Cdhv4mVouHBOa3Lzg4y
	sDFYZrVnGSf6mJAtsPjPG6FUNKrILlCmLdh5X3RmPvWtBLY92ywDX+NpmEVoCob2ii1BXQQBtgT
	bhqFdbnt9J6wV+wSRFi4VtF9d7vZaeJU/Rx+mvN6bnBLnHsiMNeK48RLsBZdRtVaNve6TtTT00a
	RHTWa1HA5Bf9LEYtizBmfrt3wQOhKL7xkFPwbB2TxwVQI774dx0YpUsvySrU9wMU7Flh3yVtfdW
	qNPyCjz0rQsZyr/SwV7p2pPtGbb41nEhNxEQwbRmqI8gQRMs5I4A/lsUx8LzMKGuoDLDZykQQJD
	0YVoSY1ULOP+SNrTqUigg2AGL/xHS5oP7REflvn3yKDrCw
X-Received: by 2002:a05:7300:d58d:b0:34b:354b:79b9 with SMTP id 5a478bee46e88-34b355ad91amr317545eec.12.1790636916413;
        Mon, 28 Sep 2026 16:08:36 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347328dd123sm9211297eec.13.2026.09.28.16.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 16:08:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xBKSY-00000007uAr-1P1O;
	Mon, 28 Sep 2026 20:08:34 -0300
Date: Mon, 28 Sep 2026 20:08:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sonang Patel <sonangp@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 11/11] PCI/TSM: Add reference-counted contexts for
 vdevice providers
Message-ID: <20260928230834.GL163130@ziepe.ca>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-12-aneesh.kumar@kernel.org>
 <arq2Ql3-q9EApe3X@sonangrm.nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arq2Ql3-q9EApe3X@sonangrm.nvidia.com>

On Tue, Sep 29, 2026 at 12:17:30AM +0530, Sonang Patel wrote:
> On Thu, 17 Sep 2026 19:31:59 +0530, Aneesh Kumar K.V (Arm) wrote:
> > +		if (is_pci_tsm_pf0(pdev)) {
> > +			if (pci_tsm_disconnect(pdev))
> > +				pci_warn(pdev, "TSM connection is still in use\n");
> > +		} else {
> > +			tsm_remove(pdev->tsm);
> > +		}
> 
> What happens if the PCI device is removed (e.g. sysfs remove, surprise
> hot-unplug) while the vDEVICE/TDI still exists?
> Since removal cannot be refused, should the remove path still force
> the unbind/unlock?

vfio prevents that. It currently will block the sysfs remove until
vfio is closed.

If we ever decide to fix that then vfio would have to tear down the
iommufd vdevice before allowing itself to be destroyed.

We don't need any lifetime nonsense once we are inside an iommufd
context, its existing locking scheme is very strong already. tsm
should not be allowed to change while a driver is bound, and basically
I shouldn't see any refcounting or locking in any of these paths
stemming from a bound driver context in iommufd.

Jason
