From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [iommu:core 3/3] drivers/iommu/iova.c:36: error: redefinition of
	'init_iova_domain'
Date: Wed, 22 Mar 2017 19:36:52 +0100
Message-ID: <20170322183651.GA27374@ulmo.ba.sec>
References: <201703230212.uKXA27d6%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7627803871016441870=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <201703230212.uKXA27d6%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============7627803871016441870==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 02:28:27AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git co=
re
> head:   21aff52ab2c831c2f07d48e2fa8d4bab26a66992
> commit: 21aff52ab2c831c2f07d48e2fa8d4bab26a66992 [3/3] iommu: Add dummy i=
mplementations for !IOMMU_IOVA
> config: x86_64-randconfig-a0-03222342 (attached as .config)
> compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
> reproduce:
>         git checkout 21aff52ab2c831c2f07d48e2fa8d4bab26a66992
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64=20
>=20
> All errors (new ones prefixed by >>):
>=20
> >> drivers/iommu/iova.c:36: error: redefinition of 'init_iova_domain'
>    include/linux/iova.h:170: note: previous definition of 'init_iova_doma=
in' was here
> >> drivers/iommu/iova.c:202: error: redefinition of 'alloc_iova_mem'
>    include/linux/iova.h:120: note: previous definition of 'alloc_iova_mem=
' was here
> >> drivers/iommu/iova.c:208: error: redefinition of 'free_iova_mem'
>    include/linux/iova.h:125: note: previous definition of 'free_iova_mem'=
 was here
> >> drivers/iommu/iova.c:214: error: redefinition of 'iova_cache_get'
>    include/linux/iova.h:111: note: previous definition of 'iova_cache_get=
' was here
> >> drivers/iommu/iova.c:235: error: redefinition of 'iova_cache_put'
>    include/linux/iova.h:116: note: previous definition of 'iova_cache_put=
' was here
> >> drivers/iommu/iova.c:261: error: redefinition of 'alloc_iova'
>    include/linux/iova.h:137: note: previous definition of 'alloc_iova' wa=
s here
> >> drivers/iommu/iova.c:323: error: redefinition of 'find_iova'
>    include/linux/iova.h:177: note: previous definition of 'find_iova' was=
 here
> >> drivers/iommu/iova.c:343: error: redefinition of '__free_iova'
>    include/linux/iova.h:133: note: previous definition of '__free_iova' w=
as here
> >> drivers/iommu/iova.c:361: error: redefinition of 'free_iova'
>    include/linux/iova.h:129: note: previous definition of 'free_iova' was=
 here
> >> drivers/iommu/iova.c:380: error: redefinition of 'alloc_iova_fast'
>    include/linux/iova.h:151: note: previous definition of 'alloc_iova_fas=
t' was here
> >> drivers/iommu/iova.c:421: error: redefinition of 'free_iova_fast'
>    include/linux/iova.h:145: note: previous definition of 'free_iova_fast=
' was here
> >> drivers/iommu/iova.c:435: error: redefinition of 'put_iova_domain'
>    include/linux/iova.h:183: note: previous definition of 'put_iova_domai=
n' was here
> >> drivers/iommu/iova.c:511: error: redefinition of 'reserve_iova'
>    include/linux/iova.h:158: note: previous definition of 'reserve_iova' =
was here
> >> drivers/iommu/iova.c:552: error: redefinition of 'copy_reserved_iova'
>    include/linux/iova.h:165: note: previous definition of 'copy_reserved_=
iova' was here
> >> drivers/iommu/iova.c:572: error: redefinition of 'split_and_remove_iov=
a'
>    include/linux/iova.h:187: note: previous definition of 'split_and_remo=
ve_iova' was here
> >> drivers/iommu/iova.c:887: error: redefinition of 'free_cpu_cached_iova=
s'
>    include/linux/iova.h:195: note: previous definition of 'free_cpu_cache=
d_iovas' was here

*sigh* I think I messed up the #ifdef line. The attached .config has
CONFIG_IOMMU_IOVA=3Dm, which means that the #ifdef won't be true. I think
the proper fix would be to:

-#ifdef CONFIG_IOMMU_IOVA
+#ifdef IS_ENABLED(CONFIG_IOMMU_IOVA)

Joerg, can you fix that up yourself or do you want me to resend the
patch with the fix rolled in?

Thierry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljSxD8ACgkQ3SOs138+
s6HHzhAAhqmBK3BMA5ExKU24HmVw2Axw2cLYzNsSJ3okKi2tCc9QrXJ5y4yBwC1C
k7MrZ6ApOgdsxn8QBJUnh/IhNAmEmNAhKPNpp5H+8CHO7eAvAcIGuxRzNiXl0UTv
EuNxfTvIjyoweYX3g9+UFPy7uOvnTbAqFn4PqxnFuFeGEZ35NYJ4sGwMGtjQTORG
T1DTTqgZcVU0ig+L4s2NfMjkRVhWxZr80OwRSp4/iWDsijrb9XGJDEbXoQR0cOjZ
s1m8jrYkcthir/8MI46r7rsJ3yqib77nNzO1zRRehtZXosqv0C52uFcSC2in3+b2
rHEpu9liQ6xbsGfr9nbCyw6z/pk5xgwy3Kbs8smVEqFRqBupEc6fQGa4A/3a+6rv
VsSN1AmbXKSm044jLEusWP2w9Vf5t5v3+JtAC5X4mBYeBNQYTQe7l6+/sNR5HLPR
ckDRqBO6cTmYs+BGH1Oag+P91gkEn02pVb9DgBcmiF9XaL8c59qtsCk04h2egB9Z
m3KAKu4IShgg++T2rlhk7in8i2PyBmRjdEaTQJvUzW+nLv59u3pmEWjW+NjynOuk
emQA2bVOo7oWlqPFavh7/S0G47glIrcvTMamkJEJgkjP87Z2jVQjepcqs8YZG3uu
mL31DFg5FHBWRsoN86Kn1wiLtX4gY4D174Q/XTRowQ0wEd6/62A=
=GiNB
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

--===============7627803871016441870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7627803871016441870==--
