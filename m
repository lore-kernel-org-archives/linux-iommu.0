From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/tegra: smmu: Use __debugfs_create_dir
Date: Wed, 8 Aug 2012 18:11:29 +0300
Message-ID: <20120808151128.GC9091@arwen.pp.htv.fi>
References: <1344407073-12030-1-git-send-email-hdoyu@nvidia.com>
	<1344407073-12030-3-git-send-email-hdoyu@nvidia.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0643751343999762619=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1344407073-12030-3-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============0643751343999762619==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 08, 2012 at 09:24:33AM +0300, Hiroshi Doyu wrote:
> The commit c3b1a35 "debugfs: make sure that debugfs_create_file() gets
> used only for regulars" doesn't allow to use debugfs_create_file() for
> dir. Use the version with "data", __debugfs_create_dir().
>=20
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Reported-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 5e51fb7..41aff7a 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -1035,9 +1035,7 @@ static void smmu_debugfs_create(struct smmu_device =
*smmu)
>  	int i;
>  	struct dentry *root;
> =20
> -	root =3D debugfs_create_file(dev_name(smmu->dev),
> -				   S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
> -				   NULL, smmu, NULL);
> +	root =3D __debugfs_create_dir(dev_name(smmu->dev), NULL, smmu);

why would the directory need extra data ? Looking in mainline,
tegra-smmu.c doesn't have any debugfs support, where can I see the
patches adding debugfs to tegra-smmu ? It doesn't look correct that the
directory will have a data field.

--=20
balbi

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQIoGgAAoJEIaOsuA1yqREoO4P/3IGJvcLfa5Uv9B/cTujVivE
pfCLPj9x6+MXNKl+J5Qkqw6PuSDC011vRd8rdWL0SX7bpVYpR7ES9BTr0ryPlvFj
Yy/UboqL5YxMFqLiDOO5xzb6YFXmjXixvnPAZ/CngudVqrXeXv5aPUQBxwNBFPDV
QL1svrcFBEtgdOqfvspBHF4lLnTJGOe2Z7U2k/cqbWsKbunvxUDrDtXcciRXHuNs
+QDHzNS6PH7q4Qv+oqTI01pKAniTVzrCGKYBeX7fZipAZbIgcEyLIsx562i4hzzA
7IEaX9ugpEw+p3pilGGIAFxXbiao+EUalP8M1D0dg8296YctjmPa8Lna7986mVH3
5w7zHL65RnbvIQKRHZgbn9+CLUrBSz5hASbHDyIif0huADnIrcTOc+oSjFkqLRL+
R2N6YSQxEgdkVRZOWyUXJrSOC2Eu607Pj3+bUS5FcOx9gn0c8oC03ohLxgTQxIdu
bJEHiD5TpsJplDczXlVcZ/qaMaCtO4Ggp7xtzlZzQroVtG75q9YeZDCfehtaq3oo
0J4jbyph/T3wh/cSm7iI7VaXLo09ogfS9J1TQM1AUmZ44Dip4kNBpWgKbMj6fT8e
xaUFbQA69WjpHw1D+NZai0SHvoNFJpZhyQI0yQR8P7WswfQZ4xc5XuUAK953xncQ
yTM7Zx/Msoz/T0rJgQth
=b59e
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--

--===============0643751343999762619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0643751343999762619==--
