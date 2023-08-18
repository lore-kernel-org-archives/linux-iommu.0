Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F417AAC
	for <iommu@lists.linux.dev>; Fri, 18 Aug 2023 15:56:23 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D50C11F8AC;
	Fri, 18 Aug 2023 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692374181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ck7ckU+/gf4JNt8Ash+l5BzHSiiOBGSDD7RN1DViGuc=;
	b=xUUI8Jy2qVLDxk2Yw2zOCL3/NoCJwsU9ZzCz2YbFQhpbMUFcIdW+xRr6TIGKYQbtEtBcF5
	UmVOc86eTAqtXrx57kAf1sx2FmN/DDmu6qKcvvJVIBrbhLdhFES9kqMTLomCpD2d7yOrrU
	3x3835OVhOIEirjRygYLE6ygekxkha4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692374181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ck7ckU+/gf4JNt8Ash+l5BzHSiiOBGSDD7RN1DViGuc=;
	b=MqAQxNBbpshhWYUCKYeVoIwqCDc650X0W4PmPQ97gUkfa2xi1xyghgdHMbEhsbUG/VrfBS
	SxtaCxvDN0Rm/wBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8DAED13441;
	Fri, 18 Aug 2023 15:56:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id uWVpIaWU32RAbQAAMHmgww
	(envelope-from <jroedel@suse.de>); Fri, 18 Aug 2023 15:56:21 +0000
Date: Fri, 18 Aug 2023 17:56:20 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
Message-ID: <ZN-UpDFHab0vGuXp@suse.de>
References: <CGME20230809144403eucas1p1345aec6ec34440f1794594426e0402ab@eucas1p1.samsung.com>
 <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
 <d090f196-a5c2-b188-31bf-e42553d8d251@samsung.com>
 <ZN5n7GnlrTS6s5Yg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZN5n7GnlrTS6s5Yg@nvidia.com>

On Thu, Aug 17, 2023 at 03:33:16PM -0300, Jason Gunthorpe wrote:
> Bascially.. Yikes!

Hmm, that is a difficult situation. Even if the problem is a misuse of
the APIs we can not just blindly break other drivers by our core
changes.

We need to resolve this situation pretty soon, otherwise I need to
remove the locking rework patches from the IOMMU tree until the
callers are fixed.

Is there a way to keep the broken drivers working for now?

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany

(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman

