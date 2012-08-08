From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/tegra: smmu: Use __debugfs_create_dir
Date: Wed, 8 Aug 2012 18:31:02 +0300
Message-ID: <20120808153100.GE9091@arwen.pp.htv.fi>
References: <1344407073-12030-1-git-send-email-hdoyu@nvidia.com>
	<1344407073-12030-3-git-send-email-hdoyu@nvidia.com>
	<20120808151128.GC9091@arwen.pp.htv.fi>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5603982244517997629=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120808151128.GC9091-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============5603982244517997629==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 08, 2012 at 06:11:29PM +0300, Felipe Balbi wrote:
> Hi,
>=20
> On Wed, Aug 08, 2012 at 09:24:33AM +0300, Hiroshi Doyu wrote:
> > The commit c3b1a35 "debugfs: make sure that debugfs_create_file() gets
> > used only for regulars" doesn't allow to use debugfs_create_file() for
> > dir. Use the version with "data", __debugfs_create_dir().
> >=20
> > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > Reported-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/tegra-smmu.c |    4 +---
> >  1 files changed, 1 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > index 5e51fb7..41aff7a 100644
> > --- a/drivers/iommu/tegra-smmu.c
> > +++ b/drivers/iommu/tegra-smmu.c
> > @@ -1035,9 +1035,7 @@ static void smmu_debugfs_create(struct smmu_devic=
e *smmu)
> >  	int i;
> >  	struct dentry *root;
> > =20
> > -	root =3D debugfs_create_file(dev_name(smmu->dev),
> > -				   S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
> > -				   NULL, smmu, NULL);
> > +	root =3D __debugfs_create_dir(dev_name(smmu->dev), NULL, smmu);
>=20
> why would the directory need extra data ? Looking in mainline,
> tegra-smmu.c doesn't have any debugfs support, where can I see the
> patches adding debugfs to tegra-smmu ? It doesn't look correct that the
> directory will have a data field.

Looking at linux-next I found the commit which added it:

> @@ -892,6 +909,164 @@ static struct iommu_ops smmu_iommu_ops =3D {
>  	.pgsize_bitmap	=3D SMMU_IOMMU_PGSIZES,
>  };
> =20
> +/* Should be in the order of enum */
> +static const char * const smmu_debugfs_mc[] =3D { "mc", };
> +static const char * const smmu_debugfs_cache[] =3D {  "tlb", "ptc", };
> +
> +static ssize_t smmu_debugfs_stats_write(struct file *file,
> +					const char __user *buffer,
> +					size_t count, loff_t *pos)
> +{
> +	struct smmu_device *smmu;
> +	struct dentry *dent;
> +	int i, cache, mc;
> +	enum {
> +		_OFF =3D 0,
> +		_ON,
> +		_RESET,
> +	};
> +	const char * const command[] =3D {
> +		[_OFF]		=3D "off",
> +		[_ON]		=3D "on",
> +		[_RESET]	=3D "reset",
> +	};
> +	char str[] =3D "reset";
> +	u32 val;
> +	size_t offs;
> +
> +	count =3D min_t(size_t, count, sizeof(str));
> +	if (copy_from_user(str, buffer, count))
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(command); i++)
> +		if (strncmp(str, command[i],
> +			    strlen(command[i])) =3D=3D 0)
> +			break;
> +
> +	if (i =3D=3D ARRAY_SIZE(command))
> +		return -EINVAL;
> +
> +	dent =3D file->f_dentry;
> +	cache =3D (int)dent->d_inode->i_private;

cache you can figure out by the filename. In fact, it would be much
better to have tlc and ptc directories with a "status" filename which
you write ON/OFF/RESET or enable/disable/reset to trigger what you need.

For that to work, you should probably hold tlb and ptc on an array of
some sort, and pass those as data to their respective "status" files as
the data field. If tlb and ptc are properly defined structures which can
point back to smmu, then you have everything you need.

I mean something like:

struct smmu;

struct mc {
	const char *name;
	void __iomem *regs;

	struct smmu *smmu;
};

struct smmu {
	struct mc mc[2]; /*what does mc stand for ? memory controller ? */

	...
};

debugfs_create_dir(smmu);
debugfs_create_dir(mc);
debugfs_create_dir(smmu->mc[1].name);
debugfs_create_dir(smmu->mc[2].name);
debugfs_create_file(&smmu->mc[1], status);
debugfs_create_file(&smmu->mc[2], status);

or something similar. You will avoid all the trickery you did here to
achieve what you need.

> +	mc =3D (int)dent->d_parent->d_inode->i_private;
> +	smmu =3D dent->d_parent->d_parent->d_inode->i_private;
> +
> +	offs =3D SMMU_CACHE_CONFIG(cache);
> +	val =3D smmu_read(smmu, offs);
> +	switch (i) {
> +	case _OFF:
> +		val &=3D ~SMMU_CACHE_CONFIG_STATS_ENABLE;
> +		val &=3D ~SMMU_CACHE_CONFIG_STATS_TEST;
> +		smmu_write(smmu, val, offs);
> +		break;
> +	case _ON:
> +		val |=3D SMMU_CACHE_CONFIG_STATS_ENABLE;
> +		val &=3D ~SMMU_CACHE_CONFIG_STATS_TEST;
> +		smmu_write(smmu, val, offs);
> +		break;
> +	case _RESET:
> +		val |=3D SMMU_CACHE_CONFIG_STATS_TEST;
> +		smmu_write(smmu, val, offs);
> +		val &=3D ~SMMU_CACHE_CONFIG_STATS_TEST;
> +		smmu_write(smmu, val, offs);
> +		break;
> +	default:
> +		BUG();
> +		break;
> +	}
> +
> +	dev_dbg(smmu->dev, "%s() %08x, %08x @%08x\n", __func__,
> +		val, smmu_read(smmu, offs), offs);
> +
> +	return count;
> +}
> +
> +static int smmu_debugfs_stats_show(struct seq_file *s, void *v)
> +{
> +	struct smmu_device *smmu;
> +	struct dentry *dent;
> +	int i, cache, mc;
> +	const char * const stats[] =3D { "hit", "miss", };
> +
> +	dent =3D d_find_alias(s->private);
> +	cache =3D (int)dent->d_inode->i_private;
> +	mc =3D (int)dent->d_parent->d_inode->i_private;
> +	smmu =3D dent->d_parent->d_parent->d_inode->i_private;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(stats); i++) {
> +		u32 val;
> +		size_t offs;
> +
> +		offs =3D SMMU_STATS_CACHE_COUNT(mc, cache, i);
> +		val =3D smmu_read(smmu, offs);
> +		seq_printf(s, "%s:%08x ", stats[i], val);
> +
> +		dev_dbg(smmu->dev, "%s() %s %08x @%08x\n", __func__,
> +			stats[i], val, offs);
> +	}
> +	seq_printf(s, "\n");
> +
> +	return 0;
> +}
> +
> +static int smmu_debugfs_stats_open(struct inode *inode, struct file *fil=
e)
> +{
> +	return single_open(file, smmu_debugfs_stats_show, inode);
> +}
> +
> +static const struct file_operations smmu_debugfs_stats_fops =3D {
> +	.open		=3D smmu_debugfs_stats_open,
> +	.read		=3D seq_read,
> +	.llseek		=3D seq_lseek,
> +	.release	=3D single_release,
> +	.write		=3D smmu_debugfs_stats_write,
> +};
> +
> +static void smmu_debugfs_delete(struct smmu_device *smmu)
> +{
> +	debugfs_remove_recursive(smmu->debugfs_root);
> +}
> +
> +static void smmu_debugfs_create(struct smmu_device *smmu)
> +{
> +	int i;
> +	struct dentry *root;
> +
> +	root =3D debugfs_create_file(dev_name(smmu->dev),
> +				   S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
> +				   NULL, smmu, NULL);

directories don't need data. You don't even have a file_operations
structure so when exactly are you going to access the data ? What you
did above is actually wrong. You need to either patch this ASAP or drop
the patch you wrote and rewrite the whole debugfs support.

> +	if (!root)
> +		goto err_out;
> +	smmu->debugfs_root =3D root;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(smmu_debugfs_mc); i++) {
> +		int j;
> +		struct dentry *mc;
> +
> +		mc =3D debugfs_create_file(smmu_debugfs_mc[i],
> +					 S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
> +					 root, (void *)i, NULL);

likewise here. What would you use that index for ? Even if you were to
access it, how would you use it ? Not to mention that you never, ever
access the private_data of the directory :-)

Just convert these two to the proper debugfs_create_dir()

> +		if (!mc)
> +			goto err_out;
> +
> +		for (j =3D 0; j < ARRAY_SIZE(smmu_debugfs_cache); j++) {
> +			struct dentry *cache;
> +
> +			cache =3D debugfs_create_file(smmu_debugfs_cache[j],
> +						    S_IWUGO | S_IRUGO, mc,
> +						    (void *)j,
> +						    &smmu_debugfs_stats_fops);

it would be far better to pass a structure which you actually need. In
this case 'smmu'. That will be a lot more useful for your code.

--=20
balbi

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQIoY0AAoJEIaOsuA1yqRE2t4P/jSbuauJNmav38T7zlLUOb2W
LQ87QC8SshPuxngOzxmApsZ3NWqgzxomlKGk/IXdzQw1xNvSrBKshe6jEFxfPJ0w
CmGGRxao8pFXxyOrAYBmeijX216FTMI9zaBoolR0cow+V49iTvfMXiv0I1oYMEwI
/Pc5eUkXqIaXfsaPU8DI9p5L1XErMV8enlfNi4EB2xlfx8mnPVMTLVMVYq3H/FdT
3ynsdX6eCAQr9LGfz/PUHxRxY0oIiTaO2KuySJvAwi/PSPuUYi2RtCm/nJ/Mv1Rk
ux8KLXgxnnHFPRHMGdXB4XGn3tqDpHwSzbxd+L/ys1BMNbUG8jw5fgiGoR1k96QN
Uw19ZLnDe0eFDNrKpgU9ZpsPsDE/m5NNoImr+KpNXDQnA4pOnt2Rl13mLroHNYG4
DOg+1EMYUG0aHE//eQjqZXfJYDiJf2J/wf0RvdrjLcigVTXwVbSMHcOyhgu2nwLh
/8NigJ7IwwwQYSzBolLLy3GcqtxJV6t8KUaTUJyfo8RNS0me1phDq3sAgdfF0RQP
z4VxzSBSvVo35UsI/f19FbYMA2ENibB3tRxpALBs1RcKEh7Rtkxq87Tag7FBgC3t
p3itqT4RZJNOSA5EOIiGN40zyDkxmlUXVPovxABvrxylMrOyq7rZDAMttlpzd2sv
svr/reY3qfz+FyU5HCrr
=TSzm
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--

--===============5603982244517997629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5603982244517997629==--
