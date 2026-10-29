Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265120;
	b=0fbMRiqW8wG2LBFKZ1IbjFc098+wyX1IjGZjFLVyZ2VVrwcSMLWifeM96PYtourT2qh6
	 WmGoQvlg1VYSyepjuhG9CI/vY9aTWdcfrLyKXCYcego5kPr8QRy6GVfnuO2hpwkT3d2sH
	 iI1R6zFeRX5irzPDiZWqCi6PRJbDY570EVN49SCc9B2pRiLAChv9gGGiHKl/qn0+MMmz3
	 TMlR+VcbgwSzTvdmAU5v20nuAEYcpIfYIoAnNLGX2kYgweNOoCYC5mHnXzWDVmdJrkBlo
	 e7JpDHHnJN16Fn8ITs2ajLfIvoYY/pv7GZVrXXZWThZNcft1iM05t66qbTzeCvWN0KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265120;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=dJDRsJcOuCta1CXkVGQ3wEnO6kiOTAbomKcjf+nX7kA=;
	b=v5AqODm5grZnOC9TCWB8ygmO6ULtX/ubAAmQmDJVeUx/JWLB7zPo24vODQMyjTjfU1Kt
	 zmSnI8O5IiNGDHjb0niuWrIx/SUXAB6FBJhg8Sim9lsnbNyvWLW78Vbxi8gDIt625TgWy
	 ouarRpqKkNMDXq6paQ5QJvDTMWeflT8XLJDlAL6N7Ta5HXBUrfcbw03JwZimofWy396q+
	 v9HV46rnlZVEXmWV5kP4evgxVbNwGH5JkTB4ll0Cevz5Rdsax/iiwANGQ1pLhoYc/Ey5W
	 Dz7nhn2279jiMSqSaM0+dmZlRObck+6vOMGgzg3V2HssTp6IACMWpeEU4x0JShaFLUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9RwNzbI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011F2606A31D;
	Thu, 29 Oct 2026 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9RwNzbI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485021F01825;
	Thu, 29 Oct 2026 09:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265119;
	bh=dJDRsJcOuCta1CXkVGQ3wEnO6kiOTAbomKcjf+nX7kA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=W9RwNzbI1Aj/dvWxgmNqnW+NQWRJGQmXWrPDMtduvpEAUqD0M3WNRVEB4RorZH0Zn
	 uVbCirRlQwdU64HVPGxqL3IIYrnaK8hHEAboWOompp1vS1srvyTN383Cl5iscMBd+u
	 VUQ3wZbgNEX3ZIPklFbgxyHa+YEq++yENrW2JbQn8B3Kj8qdSg72ZtZDUGTN8PSw/T
	 +Istz3KTMLLmAzIX2cGyO9hfhItKLzb7+Xail8SG4IEEgkiy76XXrjdz2ZJS6iskcz
	 pUj4KiSEg946GljtoRDEg62fZXUgI9EPkcfyK5xAWLC9iZ+v+Xpum7PyH42Y+203jF
	 qEBOgXRP2YJuQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v7 16/16] PCI/TSM: wait for vdevice contexts before
 removing a DSM
In-Reply-To: <20261013115953.GP13920@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-17-aneesh.kumar@kernel.org>
 <sashiko-outbox-163687@kernel.org> <yq5atsmr44r6.fsf@kernel.org>
 <20261012130739.GM13920@nvidia.com> <yq5aecduq6i1.fsf@kernel.org>
 <20261013115953.GP13920@nvidia.com>
Date: Thu, 29 Oct 2026 14:41:55 +0530
Message-ID: <yq5a4ie4c1lw.fsf@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Tue, Oct 13, 2026 at 03:14:54PM +0530, Aneesh Kumar K.V wrote:
>> Jason Gunthorpe <jgg@nvidia.com> writes:
>> 
>> > On Mon, Oct 12, 2026 at 03:31:17PM +0530, Aneesh Kumar K.V wrote:
>> >
>> >> With this series, vdevices hold a reference to their parent vIOMMU,
>> >> which pins arm-cca-host. sysfs unbind is disabled, and the SMCCC
>> >> provider device has no hot-unplug path.
>> >
>> > It probably needs some logic like vfio has to prevent unregister from
>> > completing if there are active users. The module pin should prevent it
>> > from ever triggering, but as a safety precaution.
>> >
>> 
>> Are you suggesting that tsm_unregister() should return an error or wait,
>> as device removal does? Returning an error would be much easier to
>> implement by adding an unregistering flag to tsm_dev, set under
>> pci_tsm_rwsem after checking all pf0->context_users counters.
>
> I didn't check it closely but the usual flow is for 'unregister' to
> wait until everything is done using it, possibly with a shootdown
> mechanism.
>
> I'm not sure we can implement a sane shootdown for iommufd's
> consumption of the tsm, but we can at least do the wait.
>

This will require.

@@ -116,6 +119,13 @@ struct tsm_dev {
 	struct device dev;
 	int id;
 	const struct pci_tsm_ops *pci_ops;
+	/* Serializes user acquisition against unregister */
+	struct mutex users_lock;
+	/* Written under users_lock, read with READ_ONCE() by bus code. */
+	bool unregistering;
+	/* Registration reference plus users that must finish before teardown. */
+	refcount_t users;
+	struct completion users_drained;
 };
 

When a vIOMMU pins the tsm_dev, it must also increment users. This
requires a new users_lock, since all existing locking is in pci_tsm.

I can add this as a separate patch, and then we can decide whether to
keep it. I wonder whether we can avoid this complexity, since the vIOMMU
already pins the TSM backend module and we expect unregister to be
called only from module_exit().

-aneesh
