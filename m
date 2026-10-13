Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0C48A8C6;
	Tue, 13 Oct 2026 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884700; cv=none; b=jCT1UiZcxoEMFZvZUp68yx9v+3hCxQYZHf91o93vlrINtNxhmtQNSUjsX2xxvlSzGXVU3IMws33exc2nuKMoozx9wa9kJhbOK59QtJ6Ji3TSf8H2IU42hI23gFZWJlxjENoWWf7ZKTIYO+Y5kJPJAg1gEpqwrKa1JETSjFr7dZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884700; c=relaxed/simple;
	bh=baI/Z7T0bwwNIrODzYKxBTCIfUH5WsrcaSPxkQXMS38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tCLnpmouZdyTkGY0TmfR4XT1Ofz8G3aJyYFQbMeZk/QznA9YNrQAyHqAX6iH7cgd4YOdTpxMRCW1TMVb1kPk4OaAUMcWqPYdzBVCg0L2W0+fWbEbTDJooIDINkLYow6P7T7enRZBTfmIHPC52QZN6+wQf92hjfzg3tQaJW/LXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4gYy5/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4gYy5/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9D51F000FF;
	Tue, 13 Oct 2026 09:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791884699;
	bh=baI/Z7T0bwwNIrODzYKxBTCIfUH5WsrcaSPxkQXMS38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Y4gYy5/t16IBoLeQuvOgguyRav6A1B9TBV4bcQm+19mdAtrEG20QomQxeN4NJurKQ
	 2kdlNv3V9sMjRN+RGyMEa0dEiaWGXIqI33qJOk3EyTFm49QD0mzts6pdNKHnDgtd6E
	 icdJsF/XEgs6xGK5unA0dSAIKfn39Vkalw32aqOSIdmXGNe6VRVbpi5Lc9X6T1ZTjF
	 sCvY7ILOliqI9BujkF/cIQkYsjs6bSHc/pu6u6qJPErvnDX1+v5XIniLkEGKkl95qZ
	 XkFkfyBOtjhb/LhzJixL9tpI87Z7pMb3MwxSB1ayFfcoGoWPd98dJ++WLp6x3J/Thb
	 tYidCCc5Asgjw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v7 16/16] PCI/TSM: wait for vdevice contexts before
 removing a DSM
In-Reply-To: <20261012130739.GM13920@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-17-aneesh.kumar@kernel.org>
 <sashiko-outbox-163687@kernel.org> <yq5atsmr44r6.fsf@kernel.org>
 <20261012130739.GM13920@nvidia.com>
Date: Tue, 13 Oct 2026 15:14:54 +0530
Message-ID: <yq5aecduq6i1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Mon, Oct 12, 2026 at 03:31:17PM +0530, Aneesh Kumar K.V wrote:
>
>> With this series, vdevices hold a reference to their parent vIOMMU,
>> which pins arm-cca-host. sysfs unbind is disabled, and the SMCCC
>> provider device has no hot-unplug path.
>
> It probably needs some logic like vfio has to prevent unregister from
> completing if there are active users. The module pin should prevent it
> from ever triggering, but as a safety precaution.
>

Are you suggesting that tsm_unregister() should return an error or wait,
as device removal does? Returning an error would be much easier to
implement by adding an unregistering flag to tsm_dev, set under
pci_tsm_rwsem after checking all pf0->context_users counters.

-aneesh
