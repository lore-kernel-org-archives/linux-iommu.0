Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1D519F40A;
	Mon, 16 Jun 2025 04:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750047307; cv=none; b=laHrFW4DvVvmSYeH5rK0axddbOuqRvgpcs2SVReVbRUV1Ju3YvqFEkOnewr5593pz6auIzvannLqQv65Is+jwkQ0SE5QksmCe91cKLAuExS/bKPOqv/lGUF+8NKkKqb3Kte6u8D7bd/YuaUHPD2pCW6wCF//+fZ8qN5MxGCSLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750047307; c=relaxed/simple;
	bh=rM9bL9wU00reQIIaJPIlupar5fdGN2JTE/STQh4Kwy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hEtSeNTpCjjZbsLEEW+MRUuuyGqlixsRsfa1wEArI/LJCHsFBw3ZsF7Uqe7A96CBPY5nQl4miqJUOhab87/QAFB9zRefo2g2qjl6zBnayHt7sDFfoq44ejaF+ztGMWHxMHnBTF3KGzh5U9GDYonsK4+ZLBf4JPb1ta10Y+Net4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pho//p2s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pho//p2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6061C4CEEA;
	Mon, 16 Jun 2025 04:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750047307;
	bh=rM9bL9wU00reQIIaJPIlupar5fdGN2JTE/STQh4Kwy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pho//p2sCMtqAHmfvjHeegXm1CNgbt731roXNYYkYIUi5nT1Ulu3PkBwnT73QZAfI
	 /7MtdLlan1GgNIL+clL6kRIyutQEB+PB2SnFW6F4ZBRg03/QVye8DxrMFAXHxSZS/T
	 ApayrsqxuEcw/TuSTbEfb/OPgX9VIwqdPZMz90zeK71BjQlIBeqHexb92pQjgCzKuu
	 6xiRsEs+8vL6IyKGpuEBjyioW0JkpiNme2R+Z/SphrqtDr+7wlVTcAG3dK28Q9G/B5
	 u4DU3rzspodA/cVWTn9KanSc/p4uJS6EoZmpIj4p3KzsCyyAKEemOxypMyA//xmtcZ
	 +6UIYIN81NXRQ==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: RE: [RFC PATCH] iommufd: Destroy vdevice on device unbind
In-Reply-To: <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250612172645.GA1011960@ziepe.ca>
 <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
Date: Mon, 16 Jun 2025 09:45:00 +0530
Message-ID: <yq5aecvktj97.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Tian, Kevin" <kevin.tian@intel.com> writes:

>> From: Jason Gunthorpe <jgg@ziepe.ca>
>> Sent: Friday, June 13, 2025 1:27 AM
>> 
>> On Thu, Jun 12, 2025 at 08:05:37AM +0000, Tian, Kevin wrote:
>> > The initial v5 patch [1] from Nicolin was similar to what this
>> > patch does. Jason explained [2] why it's unsafe to destroy "userspace
>> > created" objects behind the scene. And a general rule in iommufd is
>> > to not take long term references on kernel owned objects.
>> >
>> > [1]
>> https://lore.kernel.org/all/53025c827c44d68edb6469bfd940a8e8bc6147a5.1
>> 729897278.git.nicolinc@nvidia.com/
>> > [2] https://lore.kernel.org/all/20241029184801.GW6956@nvidia.com/
>> 
>> Yes, we have a problem here where we both can't let VFIO go away while
>> the vdevice is present nor can we let the vdevice be fully deleted.
>> 
>> At that point it wasn't such a big deal, but the new stuff seems to
>> make vdevice more complicated that it cannot out live the idevice.
>> 
>> Probably the answer is to tombstone the vdevice in the xarray so the
>> ID is still there and userspace can still destroy it while destroying
>> everything linked to it?
>> 
>
> yeah that seems to be the option if the said life-cycle dependency
> cannot be removed...
>
> conceptually it's still a bit unclean as the user needs to know that
> the vdevice object is special after idevice is unbound i.e. it can only
> be destroyed instead of supporting any other kind of operations.
>
> hmm if the user needs to build certain knowledge anyway can we 
> go one step further to state that the vdevice will be destroyed
> automatically once its idevice is unbound so the user shouldn't
> attempt to explicitly destroy it again after unbind?

That is what this patch is does. ie, it automatically destroy the
vdevice while unbinding the idevice.

-aneesh
