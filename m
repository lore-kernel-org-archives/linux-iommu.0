Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F971DF251;
	Mon, 28 Oct 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137564; cv=none; b=Lr4lCDyzRpPl7iPe+WeCvxJ8qatFOPrvmNc9t0GEnjwafNrF/m0bXDSsWShWokA23HKzKbTrbvhe9c3YG2GqO75umSwqBVM+uE3VGy7vriSCtuJtiK4Rryx4Lgu+qi+7rpbMqOpF3aC7U9UOM0a2XlGntFLN2wY6bUeyF2Yf6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137564; c=relaxed/simple;
	bh=wBM3YyAQDgxYAAlMYnnUUBE+DwhHmnmpDhboAb817Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaVKzORHqIVU4nuicpT8QjpGr6OyCRQ1LtGJgcEWmpxwIY6qbdiLOaoxeDiZtK/wXGW3osHPTV4vw7ssekkwXv1JKlWSclsUuQOgB/1Z3D5eZH2Q5deIvwMFS4nBNZZz7vKweOoecCgBdEXorEj3bcJ0cWrbUIErbmgZGgQWrKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21FFC4CEC3;
	Mon, 28 Oct 2024 17:46:01 +0000 (UTC)
Date: Mon, 28 Oct 2024 17:45:59 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhangzekun11@huawei.com, john.g.garry@oracle.com,
	dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Message-ID: <Zx_N1xVHFskgx-KX@arm.com>
References: <ZY1osaGLyT-sdKE8@shredder>
 <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>
 <ZZ2AqZT4dD-s01q9@shredder>
 <ab22c439-e7da-49b5-b20b-856daf376c02@arm.com>
 <ZZ7atzgT6_kOvWnJ@arm.com>
 <ZZ-ky9UCoHwbyqfn@shredder>
 <ZZ-_LWz_4KxOkRsA@arm.com>
 <ZaFbPnDrYT5uGqJD@shredder>
 <ZaTb8KorPFPgRqD6@shredder>
 <Zx9Fepzvrs8b6_LX@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx9Fepzvrs8b6_LX@shredder.mtl.com>

On Mon, Oct 28, 2024 at 10:04:10AM +0200, Ido Schimmel wrote:
> On Mon, Jan 15, 2024 at 09:17:04AM +0200, Ido Schimmel wrote:
> > On Fri, Jan 12, 2024 at 05:31:15PM +0200, Ido Schimmel wrote:
> > > On Thu, Jan 11, 2024 at 10:13:01AM +0000, Catalin Marinas wrote:
> > > > On Thu, Jan 11, 2024 at 10:20:27AM +0200, Ido Schimmel wrote:
> > > > > On Wed, Jan 10, 2024 at 05:58:15PM +0000, Catalin Marinas wrote:
> > > > > > Transient false positives are possible, especially as the code doesn't
> > > > > > use a double-linked list (for the latter, kmemleak does checksumming and
> > > > > > detects the prev/next change, defers the reporting until the object
> > > > > > becomes stable). That said, if a new scan is forced (echo scan >
> > > > > > /sys/kernel/debug/kmemleak), are the same objects still listed as leaks?
> > > > > > If yes, they may not be transient.
> > > > > 
> > > > > We are doing "scan" and "clear" after each test. I will disable the
> > > > > "clear" and see if the leaks persist.
> > > > 
> > > > If it is indeed a false positive
> > > 
> > > Looks like the leaks are transient. After removing the "clear" step the
> > > leaks do not seem to persist.
> > > 
> > > > you can try the patch below (I haven't given it any run-time test,
> > > > only compiled):
> > > 
> > > Will try and let you know next week.
> > 
> > Looks good. Feel free to add:
> > 
> > Tested-by: Ido Schimmel <idosch@nvidia.com>
> 
> Catalin, we have been using this patch since you posted it and haven't
> seen any issues. Can please submit it upstream?

Oh, I completely forgot about it. I'll try to do it this week. Thanks
for the reminder.

-- 
Catalin
