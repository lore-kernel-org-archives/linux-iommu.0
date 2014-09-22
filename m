From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v3 7/7] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Mon, 22 Sep 2014 11:19:35 +0200
Message-ID: <20140922091934.GH1470@ulmo>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<1410539695-29128-8-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2499594321679758755=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1410539695-29128-8-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============2499594321679758755==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xQmOcGOVkeO43v2v"
Content-Disposition: inline


--xQmOcGOVkeO43v2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 12, 2014 at 05:34:55PM +0100, Will Deacon wrote:
[...]
> +static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size)
> +{
> +	struct dma_iommu_mapping *mapping;
> +
> +	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);

If I understand correctly this will be called for each device that has
an IOMMU master interface and will end up creating a new mapping for
each of the devices. Each of these mappings will translate to a domain
in the IOMMU API, which in turn is a separate address space.

How do you envision to support use-cases where a set of devices need to
share a single domain? This is needed for example in DRM where SoCs
often have a set of hardware blocks (each with its own master interface)
that compose the display device. On Tegra for example there are two
display controllers that need access to the same IOVA domain so that
they can scan out framebuffers.

Thierry

--xQmOcGOVkeO43v2v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUH+mmAAoJEN0jrNd/PrOhD6MP/1gPxi1twkrHRTTRcbSzo2tN
h7osbzBgjsGDMnkbQchaNSykg3/NGWrN1MXDGupU0eMowewMLc94k4NHcO5/DmTY
1dDYkWZuyfn8yW6wS0VkjGKPjeTj3/XtJ4E+BqR/ylropWbLT0Pnf8qiTd+f9Eve
NC+/z3Cxk5NxypA0D31+35KiyzS0TEXmH9JrzT0q1JQxU0bk06/4JLMDGPgebzyZ
PedgOZQk0GiIX9KyYtunklPnmSpzgOcaBu6zT+IQLTkjiFkw1obWIu97Rj/IK66t
xMgWHhEvipSv6YHCy0V+i1gMaQNYlyZhOfoglXRU79p6F2+PS6U4UA8UxARnKhma
C+S2r3PLlxV7UHQ6bj9nq7S5B4RWMkg5zeBMZauP/51yKPC/b8K3f3cNlkGsYUoH
9mdLNHtXjFJ3noRWIgLlzqdbeSyXkxBofV6WwuyzUVLFRQ0FQQtQexJAUSFon1TK
PrqzTmGAcKblGc+nU/sv44L85VE2F2KXM5qNsQt7ivcjV59zRnauGmhG3Wqfy086
pzuIOTDhNXUmYDjd/eNKBFYNwv+LW3X7h2Ba5/LK8G1fj0011mzjLNw34dzErLyy
/RaIcQVS5AY4zYGxrrV9ysRnin9mMmE1hZI4s1sh4BHu1ehfiSkT0vJxc12cQUfG
B8n6xAkWfmJintO/ekBT
=r4GH
-----END PGP SIGNATURE-----

--xQmOcGOVkeO43v2v--

--===============2499594321679758755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2499594321679758755==--
