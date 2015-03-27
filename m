From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] iommu/tegra-smmu: Add debugfs support
Date: Fri, 27 Mar 2015 11:15:41 +0100
Message-ID: <20150327101539.GA17976@ulmo.nvidia.com>
References: <1427450847-17719-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427450847-17719-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2015 at 11:07:24AM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> Provide clients and swgroups files in debugfs. These files show for
> which clients IOMMU translation is enabled and which ASID is associated
> with each SWGROUP.
>=20
> Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c | 109 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/soc/tegra/mc.h     |   5 +++
>  2 files changed, 114 insertions(+)

Hi Joerg,

I forgot to mention that this patch depends on another patch that I plan
to take through the Tegra tree. That patch adds the group names that are
used by the debugfs support introduced here.

There are a couple of ways to solve this: omit this patch for v4.1 and
merge it for v4.2, at which point the dependency will have been merged.
That's obviously the simplest one and given that this is debugfs support
it isn't very critical, just nice to have.

Another possibility would be for you to ack this patch so that I can
take it into the same branch as the dependency. The remainder of this
series doesn't depend on either of the two patches, so they should be
fine for you to take into your tree.

Yet another alternative would be for me to provide a stable branch that
can be merged into the Tegra and IOMMU trees, but quite frankly I don't
think it's worth jumping through hoops like that for this particular
patch. I'd prefer either the first or second alternative, whichever
suits you best.

Thanks,
Thierry

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVFS3JAAoJEN0jrNd/PrOhhGEP/A9UooGg/9jmJPpvulSeA0r4
5zt4b3RuBzTbmesdgEdgP0LKpzeCMjSnYBM8K+j+KH+CphtzeeDxzxIqs9x7KKjp
aPts3PTD/V4KdRX09bvTBL845z6FrvGJ8skPbYW442apf21pQ9D9sHlk2cXFTh97
xqiFfNbQERZzc0wmlH7Rjg3xLMza+WhPgO1aJrHCtk4a9vbkQSQpjV/+v018zJ8P
Ziy7DHNtBEf4B/EigMAjkwW/FJjENEmG3oPbxaUqDxgeanBueLQ2MnsStTUAKNrr
zChRYSCoRoZ2HBro4beEWLzc997oMLanTFdqZMVpyOOYYK/0Akm0jTUWQy9WwSiw
+UPnr7N9OLrcO1Ou3uDod4GWy854kJoEMXbH1hm6pPL1VCPiC6JBYkjR1FM2xzQy
QfdPxbs3Qs3WFGEDRy9T2M/virCVvT2klNR25nZhujWxcHJe2bMvXxsy4o5LyQHb
xgp9P5jPU1L7jDxfHvKnDYuuRHCX1xcRDBgaoB0DipznEMSZIA018aO9z4BfDun9
begQzE2nddsTA5mUCLUVedPttVa3+nS0HYm1FAidojwSecaAqtzujZ9vGvT3J5sw
bZ9dOSWjok2tX7De/n0XXLZBsJUYv+y5emEq1ZB3WUSVoNS8IqiE3phRZzGDR6Zi
59KbyToeRLDJXsiimQeb
=2pv/
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
