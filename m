Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE1522579E
	for <iommu@lists.linux.dev>; Sat, 23 May 2026 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779507735; cv=none; b=gCQ6sSibg/i6pzB9CKu4AJymS0hdTv7O63M903ZeA8fChjL4Gc9W/E6ba2GBLYXZRGRoYqkzUUgfeiWxKNGKcyDlCGrw5QAetfQ7J03uhQjjD/RmPMT72Zv828qtDpUIk6YF+zlJK70d9oYGyiEqhGZpok5yY4PamxbXSMAz9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779507735; c=relaxed/simple;
	bh=sWUcL0ghvWfH9c8vLe3DuMJNDsCQm4s7Lyet09kVkBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7k36en216wWcAsnh32kzj5a7ot8jLvaAWmaiyqQcj7EewRJVZG1hjf53zKyXRlktYHQtP2C7w2IN08ldgvSlWKx2d4FsPqJwLyZLW01KDgdlYGQMGIru998AiOt7m+La47TnxeGHxwn7zGUgSldYDQZFgnjx3wJqGDg2hCEK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=drP2VWRs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="drP2VWRs"
Received: from localhost (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 31D5C20B7167;
	Fri, 22 May 2026 20:42:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 31D5C20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779507725;
	bh=WBEHj8LWNYyt+fUSDmIP3xslo8Xzcrnq4qiBdJggHDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=drP2VWRsXDMXgnEKCMEjKLFo2nWhAdjQLAvGR1odMD0RdNgnqllY8J9ZzIDfrKQla
	 wvb7uK0wqazJi2C4e5Ml+qql8gH08YWf/B9OoZuQBzHGDy8Ia9UMXTXNMfrnCzSoZD
	 oW/LE82bA8MPSbUJMkzpWpc5cPpZVOrbM1L+DevA=
Date: Fri, 22 May 2026 20:42:10 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, <skhawaja@google.com>,
 <pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v6 7/7] Documentation: Update VFIO NOIOMMU mode
Message-ID: <20260522204210.00002858@linux.microsoft.com>
In-Reply-To: <18733b82-9f59-4a4b-b37c-69a2e367a0ab@intel.com>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
	<20260521221155.1375144-8-jacob.pan@linux.microsoft.com>
	<18733b82-9f59-4a4b-b37c-69a2e367a0ab@intel.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Yi,

On Fri, 22 May 2026 17:42:42 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> > ++------+-------+-----------+------+---------+-------------------------=
--+
> > +| Case | GROUP | Container | CDEV | NOIOMMU | Notes
> >      |
> > ++=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +|  1   |   y   |     y     |  n   |   yes   | Group noiommu works
> >      |
> > ++------+-------+-----------+------+---------+-------------------------=
--+
> > +|  2   |   y   |     n     |  n   |   no    | Blocked - no
> > container    |
> > ++------+-------+-----------+------+---------+-------------------------=
--+
> > +|  3   |   y   |     y     |  y   |   yes   | Both paths work
> >      |
> > ++------+-------+-----------+------+---------+-------------------------=
--+
> > +|  4   |   y   |     n     |  y   |   no    | Blocked - no
> > container    |
> > ++------+-------+-----------+------+---------+-------------------------=
--+
> > +|  5   |   n   |     -     |  y   |   yes   | Cdev-only works
> >      |
> > ++------+-------+-----------+------+---------+-------------------------=
--+
> > +|  6   |   n   |     -     |  n   |   no    | No access path
> >      |
> > ++------+-------+-----------+------+---------+-------------------------=
--+
> > + =20
>=20
> Does "Bloked" mean no access path or no chance to compile? :)
By =E2=80=9CBlocked=E2=80=9D, I mean Kconfig prevents that combination from=
 being
selected, so it is not buildable as such; consequently there is no
access path at runtime.
