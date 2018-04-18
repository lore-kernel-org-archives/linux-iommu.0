From: "Yang, Shunyong" <shunyong.yang-PT9Dzx9SjPiXmMXjJBpWqg@public.gmane.org>
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
	AMD IOMMU
Date: Wed, 18 Apr 2018 05:58:48 +0000
Message-ID: <1524031122.4031.5.camel@hxt-semitech.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
	<152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
	<1523664612.2747.13.camel@intel.com>
	<efa2b7a3-04a7-20b1-3651-89ebafa85c27@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <efa2b7a3-04a7-20b1-3651-89ebafa85c27-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <EC3196134C782D4F8A962BA6463288F5-PT9Dzx9SjPiXmMXjJBpWqg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "gary.hook-5C7GfCeVMHo@public.gmane.org" <gary.hook-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "ghook-5C7GfCeVMHo@public.gmane.org" <ghook-5C7GfCeVMHo@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi, Gary and Sohil,

On Tue, 2018-04-17 at 13:38 -0400, Hook, Gary wrote:
> On 4/13/2018 8:08 PM, Mehta, Sohil wrote:
> > =

> > On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
> > > =

> > > =A0=A0
> > > +
> > > +void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
> > > +{
> > > +	char name[MAX_NAME_LEN + 1];
> > > +	struct dentry *d_top;
> > > +
> > > +	if (!debugfs_initialized())
> > Probably not needed.
> Right.

When will this check is needed?
IMO, this function is to check debugfs ready status before we want to
use debugfs. I just want to understand when we should use
debugfs_initialized();

Thanks.
Shunyong.

> =

> > =

> > =

> > > =

> > > +		return;
> > > +
> > > +	mutex_lock(&amd_iommu_debugfs_lock);
> > > +	if (!amd_iommu_debugfs) {
> > > +		d_top =3D iommu_debugfs_setup();
> > > +		if (d_top)
> > > +			amd_iommu_debugfs =3D
> > > debugfs_create_dir("amd", d_top);
> > > +	}
> > > +	mutex_unlock(&amd_iommu_debugfs_lock);
> > =

> > You can do the above only once if you iterate over the IOMMUs here
> > =A0=A0instead of doing it in=A0amd_iommu_init.
> I'm not sure it matters, given the finite number of IOMMUs in a
> system,=A0
> and the fact that this work is done exactly once. However, removal of
> a=A0
> lock is fine thing, so I'll move this around.
> =

> > =

> > =

> > > =

> > > +	if (amd_iommu_debugfs) {
> > > +		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu-
> > > > =

> > > > index);
> > > +		iommu->debugfs =3D debugfs_create_dir(name,
> > > +						=A0=A0=A0=A0amd_iommu_de
> > > bugf
> > > s);
> > > +		if (!iommu->debugfs) {
> > > +			debugfs_remove_recursive(amd_iommu_debug
> > > fs);
> > > +			amd_iommu_debugfs =3D NULL;
> > > +		}
> > > +	}
> > > +}
> > -Sohil
> > =

> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
