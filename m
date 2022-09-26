Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710113217
	for <iommu@lists.linux.dev>; Mon, 26 Sep 2022 13:48:16 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C93421AC4;
	Mon, 26 Sep 2022 13:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664200094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EUOsebiZ1Urqu06ynHBZWM/lT0mo4ClXPjZBNsAfemU=;
	b=eoXkY93/sOPpS6yBU2Xo9s5Vo2rpuAy0CiD+xUu+FyajQDC3gSH+RnvWAFdsXDKpmc5Zhg
	+MEOBv7HJu0ANd80Y8DsGG/hmPwd3C/UcZbdqlM6RcCwyYsrcuSsUpvPTRJByvU0WKA8TZ
	vOfKVabiG+tVKT5UwJo+Gms0Ir8W6Rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664200094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EUOsebiZ1Urqu06ynHBZWM/lT0mo4ClXPjZBNsAfemU=;
	b=qoCZgxXJWlGHIuLk+/PPb7wVe409ZohaCc+zSyX22Z3pq8fv9UrWdybYF2+KPu6n2lirCT
	XrjuYOabR1YrZ8BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E484C139BD;
	Mon, 26 Sep 2022 13:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +zJeNp2tMWM8dwAAMHmgww
	(envelope-from <jroedel@suse.de>); Mon, 26 Sep 2022 13:48:13 +0000
Date: Mon, 26 Sep 2022 15:48:12 +0200
From: "Rodel, Jorg" <jroedel@suse.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Eric Auger <eric.auger@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Wang <jasowang@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"Martins, Joao" <joao.m.martins@oracle.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH RFC v2 00/13] IOMMUFD Generic interface
Message-ID: <YzGtnN6pQrUxvA9Q@suse.de>
References: <0-v2-f9436d0bde78+4bb-iommufd_jgg@nvidia.com>
 <BN9PR11MB527620E859FF60250E7F08A98C479@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YyodnOJaYsimbDVK@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyodnOJaYsimbDVK@nvidia.com>

On Tue, Sep 20, 2022 at 05:07:56PM -0300, Jason Gunthorpe wrote:
> From my view, I don't get the sense the Joerg is interested in
> maintaining this, so I was expecting to have to PR this to Linus on
> its own (with the VFIO bits) and a new group would carry it through
> the initial phases.

Well, I am interested in maintaining the parts related to the IOMMU-API
and making sure future updates don't break anything. I am happy to trust
you all with the other details, as you all better understand the
use-cases and interactions with other sub-systems.

So I am fine with you sending the PR to get iommufd upstream together with
the VFIO changes (with my acks for the iommu-parts), but further updates
should still go through my tree to avoid any conflicts with other IOMMU
changes.

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

