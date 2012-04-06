From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Reparenting a platform device
Date: Fri, 6 Apr 2012 09:20:14 +0200
Message-ID: <20120406072014.GA14250@avionic-0098.mockup.avionic-design.de>
References: <20120405084258.GA19798@avionic-0098.adnet.avionic-design.de>
	<4F7DBCEE.9080400@wwwdotorg.org>
	<20120405162318.GA10628@avionic-0098.adnet.avionic-design.de>
	<20120405180805.GB11601@avionic-0098.adnet.avionic-design.de>
	<4F7DF0B3.4050500@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5433293624574738815=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4F7DF0B3.4050500-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============5433293624574738815==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Stephen Warren wrote:
> I must admit I'm not at all familiar with the IOMMU APIs, but isn't the
> IOMMU driver/subsystem itself what is managing all the allocations and
> handing them out to clients? And client drivers do things like asking
> for N pages of memory mapped into their aperture? If that is true, I'm
> not sure what the purpose is of the intermediate device you propose.
> Sorry for being somewhat clueless.

That was my impression too at first. But it seems like all the IOMMU
subsystem does is map individual pages. So you pass it a physical address of
a page along with the IO virtual address to map it to. That's at least the
way it is handled for Tegra 2 GART (and from a quick look also by the Tegra 3
SMMU). For the SMMU the situation may be different because it may not have a
fixed aperture that needs to contain the IO virtual addresses, though I must
admit I haven't looked at Tegra 3 in enough detail to judge this.

So this intermediate device would be purely an allocator for the GART
aperture and handle the actual mapping via the IOMMU. This would probably be
really simple and is in fact now done in the DRM driver. The nice thing if
this would be a separate device is that it would be easy to make it a child
of the IOMMU and wouldn't be as counter-intuitive as making the DRM device
the IOMMU's child.

Thierry

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk9+mS4ACgkQZ+BJyKLjJp+tCQCeOaGIT3XwpQy3CwOPj5pgftxY
wdwAmwTvtrhHNPhtjTM8YZtahgmwXe/2
=a6UP
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

--===============5433293624574738815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5433293624574738815==--
