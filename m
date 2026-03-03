Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97D373BEE
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561878; cv=none; b=Y/cVy6LZVt7QC7y/rxOGJqABTiZvstbwTlMihjgQ+Vkx1930HGfvyzNnHb+6wo94PAMqDc3pgIdRVTQN1I9KyGtH92pewkMZp4FNtVFxXeF+bQLYlK7PevdzFhlb+hIpu1ULZyXsDamoRJyLI5Pqe4+yRBqCabKYNAIZ+D4yGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561878; c=relaxed/simple;
	bh=F+kLyH7oiFQe2yqxkuR04wlD3B0v04pYevpP/LMQApo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVpP9m7tK9voSmeFyEwY7qVC5/xzs3hV3dr5tIQd7VpUVRDpNu1pOLlyf1hvWqmFMV7fo2O6NLc6iRYCvsmegCMUXFUpLXnLVytNUkqreC+H7SD/wo4tgTQlpGMNnzSAXjii7dxtT8Nm6HYZfJOsd+6sZ4pHs043ng4Cy/8A+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LMulkyzR; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LMulkyzR"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50336cffef9so52460291cf.0
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 10:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772561874; x=1773166674; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf1Mz0pW5YKMXMt0KYQl20EDqy7u4HiooeYLyNLCljg=;
        b=LMulkyzRoag8nNp26u7uBTE1gZkXGvBDBN5k4w/PZMNow5/f3UMOd6J1E9txVJ9Wdp
         KzSeJB3DzPYIqiS8OIgUQdPuD72d0fhxC7kuYMeODwDHdc665KF4OTlswuf0oheEu+Fi
         hU0TCfOtN6QU8pmRgV35RcnufVP6luqeUgbHc6CWA2XVDMOXCQkpCzk/VGYYYLqLJ4+h
         gxE7NovGRCXV41SnDyMqMfTCg3XPG/my3jGudMT5qMIkBcOTNmjZxTRUhwoLlSi+/VtH
         lWhN+BBdx0FJ+xVNb9L3h97SYMrC35NKt8XqVK0/bPCHSYcjm/CndoEwuctvGKj9qAGU
         Pb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772561874; x=1773166674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hf1Mz0pW5YKMXMt0KYQl20EDqy7u4HiooeYLyNLCljg=;
        b=aYA1dTZhyD+/HZBl3/9HjpFnnL6dTSArcbHV1kLBl60WkWEKSny/j3Bw+9zcrlmgVz
         nUyw0ZPmYDG8YiYyB2eqXrqXzRb7DmjZhrlq8ExIkTgqKlARBpUkApbLX+mISkMOP/+S
         fZaIoK59h4LvZHL7MYD+WfJPOOTJROy7nHl1UUkpfDThLkezqTXeZkNU1uvQmTy7kdx4
         hBiIhhJ/Ko1Qflvcz3pordk1zti0QZL58IbxYbPO8MH1N6x+llyKau30ytzTUH7VMZnJ
         biyuzByB+J2bhFHmmADZy4KwtGdoEyc6fPdCrIJ7gGmPTAti+gdrSUzoOPBAPWxS3X1B
         y4oA==
X-Gm-Message-State: AOJu0YybU/mVAB2TR5oiGJSW8DCDp5SySY7+OjzWCq50QVIQ8EfPE89H
	5BfC46xAHGaewrZkvQrmlnYcNw2UexbIG//XhlU/C0TQ8QQ6TP3WLAriHiaCq2mH6jg=
X-Gm-Gg: ATEYQzzIdEC7lNWMNRni5TjC0A6dWKZPnmk15c6ZrlaHL0P5EKp7dHfcYnIXBApwDSN
	NbLIu8+hnvICv1R6KxEoi7f3oDHMv8n4IKv1TfzC+o0ElVudGYYtCc2pf228MMkb2EQ8lYLu7z7
	nwEj9cCRx7RPtQJ9I1DVQDIc6E98ibSaq7AXeW1iaMwZuCfDT9M/UrVAmEzJ3moubBsHSxw95qH
	expmw6Q+4xtYKGYz5aW5cQOF2AROBsAFvpTGSPCdb+OX+A3zc2zi1TjVZDoDPqoyXuP556wz9xj
	zIGIO8Y5TSpls+7nDXs60v/eyE48vK/pcAf9+l4MvCEYmD35bWWdEjXiSW192QaMgj/wuJOZU2f
	UoGc6W7JNAT8any0rwcrFDYbUn8uQ0wvZQ+0aIaHMyGfBgM1qOoQZ4vpcTafs5tRDh++xRVwQpk
	eJ/iNOF3OO+tUsg3Bkf+mUQg05pLN88vZvbM1zp9ztpbuYaVdi/CaYbLiSCrHXR8OaHa2KkvSYr
	Y6gxWtg
X-Received: by 2002:ac8:7dc7:0:b0:505:ec73:822d with SMTP id d75a77b69052e-50752981c24mr234443811cf.38.1772561874341;
        Tue, 03 Mar 2026 10:17:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a02f359f2sm37042696d6.24.2026.03.03.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:17:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vxUJd-00000004PZl-0bgZ;
	Tue, 03 Mar 2026 14:17:53 -0400
Date: Tue, 3 Mar 2026 14:17:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Adhere to IVINFO[VASIZE] for address limits
Message-ID: <20260303181753.GE964116@ziepe.ca>
References: <cf1a1e3d96c3571ac5caa528caa84751d40be1bc.1772208939.git.Ankit.Soni@amd.com>
 <20260302235715.GY44359@ziepe.ca>
 <mqobyculj4g3mv2ipf2rbacbw62ew2utq2kini5hql5r22khhc@btukh6fex6zb>
 <20260303120554.GC964116@ziepe.ca>
 <4yddupv5soxmatbmcqqs4ndsffbls4r6eagoiaebalnlikx2jw@wtdby7qs6nz6>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4yddupv5soxmatbmcqqs4ndsffbls4r6eagoiaebalnlikx2jw@wtdby7qs6nz6>

On Tue, Mar 03, 2026 at 05:11:07PM +0000, Ankit Soni wrote:
> > I mean if FIELD_GET(IOMMU_IVINFO_VASIZE, amd_iommu_ivinfo) is 35 why
> > not just pass it to hw_max_vasz_lg2 and be done with it? What is the
> > point of limiting to only a few values?
> > 
> > Jason
> 
> I got your point, i added the check to match the spec, which defines valid
> values are only 32, 40, 48, and 64.

I don't think you should do that.. The valid values are the only ones
a hypervisor should install, but the kernel should be permissive and
accept everything..

Certainly it makes little sense to get something like 35 and expand it
to 64.

Jason
