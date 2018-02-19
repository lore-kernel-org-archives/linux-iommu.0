From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] fix double ;;s in code
Date: Mon, 19 Feb 2018 20:33:12 +0100
Message-ID: <20180219193312.GA3709@amd>
References: <20180217211955.GE9640@amd>
	<187435d4-5017-edb5-9b6a-b433a148bfcc@c-s.fr>
	<20180219154135.GV22199@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1302780348487197564=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180219154135.GV22199-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christophe LEROY <christophe.leroy-GgN8y9CXRhA@public.gmane.org>, elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, paulus-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, scott.bauer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, shli-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, mhocko-IBi9RG/b67k@public.gmane.org, vbabka-AlSwsSmVLrQ@public.gmane.org, Vladislav.Zakharov-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, noamca@mellanox
List-Id: iommu@lists.linux-foundation.org


--===============1302780348487197564==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-02-19 16:41:35, Daniel Vetter wrote:
> On Sun, Feb 18, 2018 at 11:00:56AM +0100, Christophe LEROY wrote:
> >=20
> >=20
> > Le 17/02/2018 =E0 22:19, Pavel Machek a =E9crit=A0:
> > >=20
> > > Fix double ;;'s in code.
> > >=20
> > > Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> >=20
> > A summary of the files modified on top of the patch would help understa=
nd
> > the impact.
> >=20
> > A maybe there should be one patch by area, eg one for each arch specific
> > modif and one for drivers/ and one for block/ ?
>=20
> Yeah, pls split this into one patch per area, with a suitable patch
> subject prefix. Look at git log of each file to get a feeling for what's
> the standard in each area.

Yeah I can spend hour spliting it, and then people will ignore it
anyway.

If you care about one of the files being modified, please fix the
bug, ";;" is a clear bug.

If you don't care ... well I don't care either.

drivers/gpu/ has four entries, i guess that's something for you.

								Pavel

> > > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drive=
rs/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > > index 61e8c3e..33d91e4 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > > @@ -718,7 +718,7 @@ static enum link_training_result perform_channel_=
equalization_sequence(
> > >   	uint32_t retries_ch_eq;
> > >   	enum dc_lane_count lane_count =3D lt_settings->link_settings.lane_=
count;
> > >   	union lane_align_status_updated dpcd_lane_status_updated =3D {{0}};
> > > -	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] =3D {{{0}}};;
> > > +	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] =3D {{{0}}};
> > >   	hw_tr_pattern =3D get_supported_tp(link);
> > > diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/=
gpu/drm/amd/powerplay/amd_powerplay.c
> > > index 4c3223a..adb6e7b 100644
> > > --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > > +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > > @@ -162,7 +162,7 @@ static int pp_hw_init(void *handle)
> > >   		if(hwmgr->smumgr_funcs->start_smu(pp_handle->hwmgr)) {
> > >   			pr_err("smc start failed\n");
> > >   			hwmgr->smumgr_funcs->smu_fini(pp_handle->hwmgr);
> > > -			return -EINVAL;;
> > > +			return -EINVAL;
> > >   		}
> > >   		if (ret =3D=3D PP_DPM_DISABLED)
> > >   			goto exit;
> > > diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c b/drivers/gpu/dr=
m/msm/mdp/mdp5/mdp5_kms.c
> > > index 3e9bba4..6d8e3a9 100644
> > > --- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
> > > +++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.c
> > > @@ -680,7 +680,7 @@ struct msm_kms *mdp5_kms_init(struct drm_device *=
dev)
> > >   	} else {
> > >   		dev_info(&pdev->dev,
> > >   			 "no iommu, fallback to phys contig buffers for scanout\n");
> > > -		aspace =3D NULL;;
> > > +		aspace =3D NULL;
> > >   	}
> > >   	pm_runtime_put_sync(&pdev->dev);
> > > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/=
drm/scheduler/gpu_scheduler.c
> > > index 2c18996..0d95888 100644
> > > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> > > @@ -461,7 +461,7 @@ void drm_sched_hw_job_reset(struct drm_gpu_schedu=
ler *sched, struct drm_sched_jo
> > >   {
> > >   	struct drm_sched_job *s_job;
> > >   	struct drm_sched_entity *entity, *tmp;
> > > -	int i;;
> > > +	int i;
> > >   	spin_lock(&sched->job_list_lock);
> > >   	list_for_each_entry_reverse(s_job, &sched->ring_mirror_list, node)=
 {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqLJngACgkQMOfwapXb+vLMuACfZ4g9YFmQ7Hp3tW427eLSrtF4
XoEAn2z1vRKfakxYqYv9uHa2jCPTvkLO
=NM8e
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

--===============1302780348487197564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1302780348487197564==--
