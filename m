Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC062FD7BD;
	Mon, 27 Oct 2025 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566819; cv=none; b=OkcwAWme5ZQmboNBZy9iZw4LlYuiGf6avxnxzjY4ggRDnHvjAAZC9ySOGlRmSKXIP10uww0ruOwtG2l2TafSUS2xMCyjlOXbgXis5L+UhXYUPXJsUs50+WJbtTQr+iJto2VXXuyy6cauAwoH1yNDgCjB+FCerdJzR7UnAl8k7zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566819; c=relaxed/simple;
	bh=1NfKMDtvOLYr/WPpOHrQJJ7c0my6rBmiQfB1Ha0Z+3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyPb9zUZU/MvDO+7/PzfFO1TavUoxuWBABeP+EEm2aearTrh9fjxja3zlg3M6S+RMsdA/0hxqkieTED10uNtr0B7DKEPdGJbyJE7Jthw6aS2i4zaY0RsBoqUb0LhzDQxnw9SjEimppiLm65NipzAzksEJk4zavxZG9801axav9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cx7HdHv/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cx7HdHv/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761566817; x=1793102817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1NfKMDtvOLYr/WPpOHrQJJ7c0my6rBmiQfB1Ha0Z+3o=;
  b=cx7HdHv/C4NwZULZqSzSpt/YvLtAnjg6tT7eJ14Qe2hf4Fgki0e3FbaV
   QwRdbmySlJZ3mzVoBMzU8Lvu3LyxiJijoGz6+HaizrOR60PEW+rsIaikc
   ujS6DMyV5gVT7Z54hcGZIK3y2kaB4S5ES0DaoAp6ID5T/3+PgqfD2zMhr
   thUFDh+O7Mm+ynqCcNalzpjn0EYAMa3lzA5ZF5gvAeo3Mw7D1Fj2myoi9
   YWc8frw099YxIbSeIlr1tTPGbCH+rZODE+FDVQwAZxz0Uji1LuYycSBnI
   MbGdRwkUEeQ1qkhlReSqnMpXXCGLweh7Zd7nb+teiWURrAuY4ntK6vnl7
   g==;
X-CSE-ConnectionGUID: uM7RQ1bsR6KqJ6k23LlegA==
X-CSE-MsgGUID: TmD76jnAQMal4RbU8RrjYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74986115"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="74986115"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:06:56 -0700
X-CSE-ConnectionGUID: HEfFwD6pRvaNzyn9whTRHw==
X-CSE-MsgGUID: Pfb7jr26RFCjJExVu8kKUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184205655"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 27 Oct 2025 05:06:52 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDLzu-000Gl1-0Q;
	Mon, 27 Oct 2025 12:06:50 +0000
Date: Mon, 27 Oct 2025 20:06:03 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: oe-kbuild-all@lists.linux.dev, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <202510271909.iEzPjNv4-lkp@intel.com>
References: <345bb7703ebd19992694758b47e371900267fa0e.1760555863.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <345bb7703ebd19992694758b47e371900267fa0e.1760555863.git.nicolinc@nvidia.com>

Hi Nicolin,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.18-rc3 next-20251027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommu-arm-smmu-v3-Explicitly-set-smmu_domain-stage-for-SVA/20251016-034754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/345bb7703ebd19992694758b47e371900267fa0e.1760555863.git.nicolinc%40nvidia.com
patch subject: [PATCH v3 3/7] iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20251027/202510271909.iEzPjNv4-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251027/202510271909.iEzPjNv4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510271909.iEzPjNv4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1062:23: error: static declaration of 'arm_smmu_invs_merge' follows non-static declaration
    1062 | struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
         |                       ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:34:
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:731:23: note: previous declaration of 'arm_smmu_invs_merge' with type 'struct arm_smmu_invs *(struct arm_smmu_invs *, struct arm_smmu_invs *)'
     731 | struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
         |                       ^~~~~~~~~~~~~~~~~~~
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1157:8: error: static declaration of 'arm_smmu_invs_unref' follows non-static declaration
    1157 | size_t arm_smmu_invs_unref(struct arm_smmu_invs *invs,
         |        ^~~~~~~~~~~~~~~~~~~
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:733:8: note: previous declaration of 'arm_smmu_invs_unref' with type 'size_t(struct arm_smmu_invs *, struct arm_smmu_invs *, void (*)(struct arm_smmu_inv *))' {aka 'long unsigned int(struct arm_smmu_invs *, struct arm_smmu_invs *, void (*)(struct arm_smmu_inv *))'}
     733 | size_t arm_smmu_invs_unref(struct arm_smmu_invs *invs,
         |        ^~~~~~~~~~~~~~~~~~~
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1227:23: error: static declaration of 'arm_smmu_invs_purge' follows non-static declaration
    1227 | struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs,
         |                       ^~~~~~~~~~~~~~~~~~~
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:736:23: note: previous declaration of 'arm_smmu_invs_purge' with type 'struct arm_smmu_invs *(struct arm_smmu_invs *, size_t)' {aka 'struct arm_smmu_invs *(struct arm_smmu_invs *, long unsigned int)'}
     736 | struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs,
         |                       ^~~~~~~~~~~~~~~~~~~
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1227:23: warning: 'arm_smmu_invs_purge' defined but not used [-Wunused-function]
    1227 | struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs,
         |                       ^~~~~~~~~~~~~~~~~~~
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1157:8: warning: 'arm_smmu_invs_unref' defined but not used [-Wunused-function]
    1157 | size_t arm_smmu_invs_unref(struct arm_smmu_invs *invs,
         |        ^~~~~~~~~~~~~~~~~~~
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1062:23: warning: 'arm_smmu_invs_merge' defined but not used [-Wunused-function]
    1062 | struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
         |                       ^~~~~~~~~~~~~~~~~~~


vim +/arm_smmu_invs_merge +1062 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

  1043	
  1044	/**
  1045	 * arm_smmu_invs_merge() - Merge @to_merge into @invs and generate a new array
  1046	 * @invs: the base invalidation array
  1047	 * @to_merge: an array of invlidations to merge
  1048	 *
  1049	 * Return: a newly allocated array on success, or ERR_PTR
  1050	 *
  1051	 * This function must be locked and serialized with arm_smmu_invs_unref() and
  1052	 * arm_smmu_invs_purge(), but do not lockdep on any lock for KUNIT test.
  1053	 *
  1054	 * Both @invs and @to_merge must be sorted, to ensure the returned array will be
  1055	 * sorted as well.
  1056	 *
  1057	 * Caller is resposible for freeing the @invs and the returned new one.
  1058	 *
  1059	 * Entries marked as trash will be purged in the returned array.
  1060	 */
  1061	VISIBLE_IF_KUNIT
> 1062	struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
  1063						  struct arm_smmu_invs *to_merge)
  1064	{
  1065		struct arm_smmu_invs *new_invs;
  1066		struct arm_smmu_inv *new;
  1067		size_t num_trashes = 0;
  1068		size_t num_adds = 0;
  1069		size_t i, j;
  1070	
  1071		for (i = j = 0; i != invs->num_invs || j != to_merge->num_invs;) {
  1072			int cmp = arm_smmu_invs_cmp(invs, i, to_merge, j);
  1073	
  1074			/* Skip any unwanted trash entry */
  1075			if (cmp < 0 && !refcount_read(&invs->inv[i].users)) {
  1076				num_trashes++;
  1077				i++;
  1078				continue;
  1079			}
  1080	
  1081			if (cmp < 0) {
  1082				/* not found in to_merge, leave alone */
  1083				i++;
  1084			} else if (cmp == 0) {
  1085				/* same item */
  1086				i++;
  1087				j++;
  1088			} else {
  1089				/* unique to to_merge */
  1090				num_adds++;
  1091				j++;
  1092			}
  1093		}
  1094	
  1095		new_invs = arm_smmu_invs_alloc(invs->num_invs - num_trashes + num_adds);
  1096		if (IS_ERR(new_invs))
  1097			return new_invs;
  1098	
  1099		new = new_invs->inv;
  1100		for (i = j = 0; i != invs->num_invs || j != to_merge->num_invs;) {
  1101			int cmp = arm_smmu_invs_cmp(invs, i, to_merge, j);
  1102	
  1103			if (cmp <= 0 && !refcount_read(&invs->inv[i].users)) {
  1104				i++;
  1105				continue;
  1106			}
  1107	
  1108			if (cmp < 0) {
  1109				*new = invs->inv[i];
  1110				i++;
  1111			} else if (cmp == 0) {
  1112				*new = invs->inv[i];
  1113				refcount_inc(&new->users);
  1114				i++;
  1115				j++;
  1116			} else {
  1117				*new = to_merge->inv[j];
  1118				refcount_set(&new->users, 1);
  1119				j++;
  1120			}
  1121	
  1122			if (new != new_invs->inv)
  1123				WARN_ON_ONCE(arm_smmu_inv_cmp(new - 1, new) == 1);
  1124			new++;
  1125		}
  1126	
  1127		WARN_ON(new != new_invs->inv + new_invs->num_invs);
  1128	
  1129		return new_invs;
  1130	}
  1131	EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_merge);
  1132	
  1133	/**
  1134	 * arm_smmu_invs_unref() - Find in @invs for all entries in @to_unref, decrease
  1135	 *                         the user counts without deletions
  1136	 * @invs: the base invalidation array
  1137	 * @to_unref: an array of invlidations to decrease their user counts
  1138	 * @flush_fn: A callback function to invoke, when an entry's user count reduces
  1139	 *            to 0
  1140	 *
  1141	 * Return: the number of trash entries in the array, for arm_smmu_invs_purge()
  1142	 *
  1143	 * This function will not fail. Any entry with users=0 will be marked as trash.
  1144	 * All tailing trash entries in the array will be dropped. And the size of the
  1145	 * array will be trimmed properly. All trash entries in-between will remain in
  1146	 * the @invs until being completely deleted by the next arm_smmu_invs_merge()
  1147	 * or an arm_smmu_invs_purge() function call.
  1148	 *
  1149	 * This function must be locked and serialized with arm_smmu_invs_merge() and
  1150	 * arm_smmu_invs_purge(), but do not lockdep on any mutex for KUNIT test.
  1151	 *
  1152	 * Note that the final @invs->num_invs might not reflect the actual number of
  1153	 * invalidations due to trash entries. Any reader should take the read lock to
  1154	 * iterate each entry and check its users counter till the last entry.
  1155	 */
  1156	VISIBLE_IF_KUNIT
> 1157	size_t arm_smmu_invs_unref(struct arm_smmu_invs *invs,
  1158				   struct arm_smmu_invs *to_unref,
  1159				   void (*flush_fn)(struct arm_smmu_inv *inv))
  1160	{
  1161		unsigned long flags;
  1162		size_t num_trashes = 0;
  1163		size_t num_invs = 0;
  1164		size_t i, j;
  1165	
  1166		for (i = j = 0; i != invs->num_invs || j != to_unref->num_invs;) {
  1167			int cmp;
  1168	
  1169			/* Skip any existing trash entry */
  1170			if (cmp <= 0 && !refcount_read(&invs->inv[i].users)) {
  1171				num_trashes++;
  1172				i++;
  1173				continue;
  1174			}
  1175	
  1176			cmp = arm_smmu_invs_cmp(invs, i, to_unref, j);
  1177			if (cmp < 0) {
  1178				/* not found in to_unref, leave alone */
  1179				i++;
  1180				num_invs = i;
  1181			} else if (cmp == 0) {
  1182				/* same item */
  1183				if (refcount_dec_and_test(&invs->inv[i].users)) {
  1184					/* KUNIT test doesn't pass in a flush_fn */
  1185					if (flush_fn)
  1186						flush_fn(&invs->inv[i]);
  1187					num_trashes++;
  1188				} else {
  1189					num_invs = i + 1;
  1190				}
  1191				i++;
  1192				j++;
  1193			} else {
  1194				/* item in to_unref is not in invs or already a trash */
  1195				WARN_ON(true);
  1196				j++;
  1197			}
  1198		}
  1199	
  1200		/* Exclude any tailing trash */
  1201		num_trashes -= invs->num_invs - num_invs;
  1202	
  1203		/* The lock is required to fence concurrent ATS operations. */
  1204		write_lock_irqsave(&invs->rwlock, flags);
  1205		WRITE_ONCE(invs->num_invs, num_invs); /* Remove tailing trash entries */
  1206		write_unlock_irqrestore(&invs->rwlock, flags);
  1207	
  1208		return num_trashes;
  1209	}
  1210	EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_unref);
  1211	
  1212	/**
  1213	 * arm_smmu_invs_purge() - Purge all the trash entries in the @invs
  1214	 * @invs: the base invalidation array
  1215	 * @num_trashes: expected number of trash entries, typically returned by a prior
  1216	 *               arm_smmu_invs_unref() call
  1217	 *
  1218	 * Return: a newly allocated array on success removing all the trash entries, or
  1219	 *         NULL on failure
  1220	 *
  1221	 * This function must be locked and serialized with arm_smmu_invs_merge() and
  1222	 * arm_smmu_invs_unref(), but do not lockdep on any lock for KUNIT test.
  1223	 *
  1224	 * Caller is resposible for freeing the @invs and the returned new one.
  1225	 */
  1226	VISIBLE_IF_KUNIT
> 1227	struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs,
  1228						  size_t num_trashes)
  1229	{
  1230		struct arm_smmu_invs *new_invs;
  1231		size_t i, j;
  1232	
  1233		if (WARN_ON(invs->num_invs < num_trashes))
  1234			return NULL;
  1235	
  1236		new_invs = arm_smmu_invs_alloc(invs->num_invs - num_trashes);
  1237		if (IS_ERR(new_invs))
  1238			return NULL;
  1239	
  1240		for (i = j = 0; i != invs->num_invs; i++) {
  1241			if (!refcount_read(&invs->inv[i].users))
  1242				continue;
  1243			new_invs->inv[j] = invs->inv[i];
  1244			j++;
  1245		}
  1246	
  1247		WARN_ON(j != new_invs->num_invs);
  1248		return new_invs;
  1249	}
  1250	EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_purge);
  1251	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
