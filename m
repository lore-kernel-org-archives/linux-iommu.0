Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B93333710F
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818236; cv=none; b=U0DdRWSYNZuYDEl9eYIHNL5QMkG/z4wo6jzAEyPxkKhvUDvpRa1ipHK6sirM5zJO+Q27EfAktjfxvBeUv+SC5OzhidyCy1A/4GeTqfBCzIv2x1s+lxMLEYdFiLX0VeC1Dzd7DCGgdDyKGXm3PHzrckttYEqArkkap+lyda7aNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818236; c=relaxed/simple;
	bh=05cJLYOftj8cARNWJ6hHU345Ux3gbpbIJ8Pet3K4X0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okktywiigbzw5RjrBP6Fmp377ozrei4lnlFx+LiHVSxhK6/vzUbkBZjWp2GLDEuRTvkiGH9W/vGXnQdxuFO1dWQhWBhK9VhIpx+9KMxQxcEHN+4ieb30w9Mr5/CftiqWpDzBXrhXdVPowvaF9QDQAayAFLenY0OKbvFFGVN2lJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=l/W2Py1o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DcoYmcVA; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="l/W2Py1o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DcoYmcVA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69C5A1400079;
	Tue, 26 May 2026 13:57:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 26 May 2026 13:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779818232;
	 x=1779904632; bh=3Tz4SyNSylIx5p8MFGqusUPHV/hF87n9RPlbNKzQtJ4=; b=
	l/W2Py1olpeLCVaeMmKlXZfCFSms4RdPZUGmeh/yekNJPxLRSwRcyTJV5oWhhmMZ
	LxRyKl2DeSmkniduOTgZFpnsnsoNwyUK5Zc2ZyWZaWpV/vsgZ0Rb/nLYI4I1iehr
	dCN2dEa/ENqODVkToHLRQ2Ys16+fAN8A6WB/L7+RakZSi05tBZ5KyeNu+DXM/a/4
	APE5u9kH/nYgOLf/hnFrX1gr/kwiIQjMXTBxmVr7iCqrbscNzPB7wjJzbadUFqSV
	hbCcnL8SFL5GTT2xhSSK8G35WPrXMdB3T/4zff3B2kEAW2Aa4q93BHusAkQ4zbr5
	AGfVVb750A2bx0fgkODWCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779818232; x=
	1779904632; bh=3Tz4SyNSylIx5p8MFGqusUPHV/hF87n9RPlbNKzQtJ4=; b=D
	coYmcVAuOxlkTxbbEIiqL5VZ57fkxg0heuOWA++WaWQLeah5FPml0AEU2dJQSiPp
	CNsbfefxy3DAi/wP6IT4cXjaNFACr5IRoqzxnESO14C8EADKC1uJ4vGUsmyXyAFv
	y3AuELR9Shzoj8lGB0esU1Ny9fRnPhFN0gqq+AuKQi/TKGoE23z3iJEohhpOLf8m
	KhcXqWgFaDQJuHFw1+aiELCuHX9sd2SZz9h3JygPvzQfxE1Nf0sw+d60Bz+0gxBw
	TS5og24I04H+ksjN77Eztu3yH7H/ge5Y/S7+TxZGiw6aiCc04SaGd3lw+20RnyOZ
	pqVa6znYoMhpSA3nMN+xw==
X-ME-Sender: <xms:994VagPiYHzRsYZKq74Hd6Y-Ap3RAnHFXLAG2hGmztkJlXCkJAQNzQ>
    <xme:994Vai6sVz5xdDzCJ2UUEhhoZ79hdbDg-8OHgsBia445JCylotV-q0_oqLIzcZN05
    jzFSD7_kfg22LKn-3F7Bk8HxbXNMXsXxXesW7rSetmwBMxcNOrMjw>
X-ME-Received: <xmr:994VatY_T7FOIpX6gQ6pqKcTSspwGsExXlQKtxmerBu_o1gBZ7LofD6_RPg>
X-ME-Proxy-Cause: dmFkZTEpotd757c1o7ymOOmd37BGMYC+ZCW/0EpD3ru4zDWJlL8ljpELDq7b/ko73Ok102
    SZyHwr+MgyQ1LJzkvsBhksjhPmRGxu2HrVC8h9AW8mI2BVMqAjHOEpKaY2SzoR1JnRJdyV
    p0oJ1o1d4FATaNtFa2Osv0J9K+4RrLdpw6+YCrQSdivSjna8R7VzBYUVTzc/gFVRhbnfKw
    xFMMZ3mZ3EH72PDvZ3XgYxMTU3MA/ilsOUMiMzojGdpW0EoiFWBFJ6ufej97fli3i68EBq
    qAhBOtTO+vct7WLWHgatSCyRaHk3xJGQ1cDLDlPhMiRoH+ztkznudWysbtoEx2OYWuENMT
    L33U2bLkvAh6kWqhQSf07UOn0EJen7qyPAH8nmkp/a910yk67mrf2hHEypRfBt3TqCoUbO
    azagTRVQFm/6fuw66pH+iC41V6Q4NlXtfbaPi5iJIusS0Ug1lBzeYGtg2Nt05/Uprb6/G3
    tS6qSdxPlLjb6HZSCqekTdUrDVq+KOvV+JgQzS5kd2pOQrNurDhW0hS9X5dh7bOQN/lktn
    DCftWG4qTid9w/6cDrLfaSxuvR5XK1Q0VM6QSkfayjyzh71TVNnwCoa8ee9vnuO/GlYkzZ
    uzYo6TAhuu4iu9bjVIividFuIKkSGgH1Xpj0+D0fMRJ68xHVAzub9AHed9Zg
X-ME-Proxy: <xmx:-N4VavFKBkL77JN-_8kfaasb1ZcmmjNHyFdUMtnbltek5LlIdp9c-w>
    <xmx:-N4Vamkh7uQ0LScXrSW75rT7tcqIMD-h83EGq-60L7hon-cqFSqgew>
    <xmx:-N4VamkrXeMQ2yKnANMUCQkk_xps_f9w2JFiJGRRnFVxwW47GyTC9Q>
    <xmx:-N4VajXxFuHEYugEg-5YyT9XGeVqxipkJubA3AH-mOxitc0ne0a47Q>
    <xmx:-N4Val2YxlEw6ePT-UU1UJuHJ7mK6Jjve4xf7K2Jsyz7ZBUN6vYVbqCa>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 13:57:10 -0400 (EDT)
Date: Tue, 26 May 2026 11:57:09 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
 <pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v6 0/7] iommufd: Enable noiommu mode for cdev
Message-ID: <20260526115709.5344f00f@shazbot.org>
In-Reply-To: <20260526083237.00006a6c@linux.microsoft.com>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
	<BL1PR11MB52717A74E37BDED067EA45018C0A2@BL1PR11MB5271.namprd11.prod.outlook.com>
	<20260526083237.00006a6c@linux.microsoft.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 08:32:37 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> Hi Kevin,
> 
> On Mon, 25 May 2026 08:30:12 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > Could you address the findings from Sashiko?
> > 
> > https://sashiko.dev/#/patchset/20260521221155.1375144-1-jacob.pan%40linux.microsoft.com
> >   
> I have go over my Sashiko review setup, but there are lots of
> false positives, like this one below we already discussed in earlier
> version. Is there a specific concern?
> 
> e.g.
> > +static bool iommufd_device_is_noiommu(struct iommufd_device *idev)
> > +{
> > +	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) &&
> > !idev->dev->iommu; +}  
> Does dynamically evaluating dev->iommu here allow the noiommu state to
> flip during the device's lifetime?

Yes, that one is at best a theoretical issue, but the next two NULL
pointer dereference if user passes noiommu device fd through an
unexpected iommufd interface appear quite real.

We're also still struggling with the Kconfig in patch 5, this Sashiko
comment is valid:

>> @@ -62,7 +61,10 @@ endif
>>  
>>  config VFIO_NOIOMMU
>>  	bool "VFIO No-IOMMU support"
>> -	depends on VFIO_GROUP
>> +	depends on VFIO_GROUP || VFIO_DEVICE_CDEV
>> +	depends on !VFIO_GROUP || VFIO_CONTAINER || IOMMUFD_VFIO_CONTAINER
>> +	depends on !VFIO_DEVICE_CDEV || !GENERIC_ATOMIC64
>
> Does this disable VFIO_NOIOMMU completely for legacy group users on
> architectures using generic atomic64 implementations?
>
> On architectures like 32-bit ARM or x86, !GENERIC_ATOMIC64 evaluates
> to false.  If a distribution enables VFIO_DEVICE_CDEV, this dependency
> resolves to false, silently breaking backwards compatibility and
> depriving legacy group-based users of noiommu support.

That's true, the question is do we care (I'd prefer to) and if so,
should we block the relevant interfaces from working though iommufd
rather than disallowing the Kconfig option.

The next issue regarding classifying emulated IOMMU devices as no-iommu
also appears valid, mdev devices like kvmgt for example.

The next issue raises a valid concern whether the dev_warn() should be
a dev_warn_once().

The sysfs naming comment is invalid, we intentionally name noiommu
devices uniquely to force userspace opt-in.

In patch 6, adding dead code is a valid comment, the unchecked asprintf
does seem to be an outlier in selftest code, the unmap comment may be a
false positive, as is the hugepage size, but the masked return comments
could arguably be skips or asserts.  There are potentially a couple
remaining nits and style issues noted.

Overall, more signal than noise afaict.  Thanks,

Alex
