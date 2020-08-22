Return-Path: <SRS0=KEvp=CA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E198C433DF
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 08:37:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2658214F1
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 08:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2658214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7A4482079A;
	Sat, 22 Aug 2020 08:37:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KjhAKWjDF8LI; Sat, 22 Aug 2020 08:37:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 00FF1203BE;
	Sat, 22 Aug 2020 08:37:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3152C07FF;
	Sat, 22 Aug 2020 08:37:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0D1EC0051
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 08:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CA8ED8849B
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 08:37:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id idvTgg19wL07 for <iommu@lists.linux-foundation.org>;
 Sat, 22 Aug 2020 08:37:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 936FE88496
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 08:37:29 +0000 (UTC)
IronPort-SDR: FhiuTLMS8SEePwQQ2gbioGwEqTiTyIoyFVBLhAP7Ww/U8oto0kykQwBxi3s8oAU/MABLMTjpHZ
 sxeXPAYGjlVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="154956867"
X-IronPort-AV: E=Sophos;i="5.76,340,1592895600"; 
 d="gz'50?scan'50,208,50";a="154956867"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2020 01:37:27 -0700
IronPort-SDR: Wkp0tEUmIRsZ6yq4U2z6k6kEtTJ5rkLUBDvxo5eHwz8L7kQUEds0rEyhxLQxmNgDIXR6D5I+rX
 +yAfeR2HoTyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,340,1592895600"; 
 d="gz'50?scan'50,208,50";a="279111526"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 22 Aug 2020 01:37:24 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1k9P1f-0001eU-Qz; Sat, 22 Aug 2020 08:37:23 +0000
Date: Sat, 22 Aug 2020 16:36:56 +0800
From: kernel test robot <lkp@intel.com>
To: Jacob Pan <jacob.pan.linux@gmail.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 5/9] iommu/ioasid: Introduce ioasid_set private ID
Message-ID: <202008221614.tDRe6JCt%lkp@intel.com>
References: <1598070918-21321-6-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <1598070918-21321-6-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, kbuild-all@lists.01.org,
 Raj Ashok <ashok.raj@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jacob,

I love your patch! Yet something to improve:

[auto build test ERROR on iommu/next]
[also build test ERROR on linux/master linus/master v5.9-rc1 next-20200821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jacob-Pan/IOASID-extensions-for-guest-SVA/20200822-123111
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: ia64-randconfig-r003-20200822 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/iommu.h:16,
                    from include/linux/of_iommu.h:6,
                    from drivers/of/device.c:7:
>> include/linux/ioasid.h:141:6: error: expected ';' before 'inline'
     141 | staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
         |      ^
         |      ;
--
   In file included from include/linux/iommu.h:16,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:34:
>> include/linux/ioasid.h:141:6: error: expected ';' before 'inline'
     141 | staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
         |      ^
         |      ;
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1094:5: warning: no previous prototype for 'amdgpu_ttm_gart_bind' [-Wmissing-prototypes]
    1094 | int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
         |     ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:55:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h:190:18: warning: 'sched_policy' defined but not used [-Wunused-const-variable=]
     190 | static const int sched_policy = KFD_SCHED_POLICY_HWS;
         |                  ^~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:65,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:55:
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
      76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
         |                                ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
      75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
         |                                ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
      74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
         |                                ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: 'dc_fixpt_two_pi' defined but not used [-Wunused-const-variable=]
      73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
         |                                ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: 'dc_fixpt_pi' defined but not used [-Wunused-const-variable=]
      72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
         |                                ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:67:32: warning: 'dc_fixpt_zero' defined but not used [-Wunused-const-variable=]
      67 | static const struct fixed31_32 dc_fixpt_zero = { 0 };
         |                                ^~~~~~~~~~~~~
--
   In file included from include/linux/iommu.h:16,
                    from drivers/gpu/drm/nouveau/include/nvif/os.h:30,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/os.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/oclass.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/device.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h:4,
                    from drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c:22:
>> include/linux/ioasid.h:141:6: error: expected ';' before 'inline'
     141 | staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
         |      ^
         |      ;
   drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c:49:1: warning: no previous prototype for 'lsb_header_tail_dump' [-Wmissing-prototypes]
      49 | lsb_header_tail_dump(struct nvkm_subdev *subdev,
         | ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/iommu.h:16,
                    from drivers/gpu/drm/nouveau/include/nvif/os.h:30,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/os.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/oclass.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/device.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/subdev/mc.h:4,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/mc/priv.h:5,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/mc/gp10b.c:24:
>> include/linux/ioasid.h:141:6: error: expected ';' before 'inline'
     141 | staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
         |      ^
         |      ;
   drivers/gpu/drm/nouveau/nvkm/subdev/mc/gp10b.c:27:1: warning: no previous prototype for 'gp10b_mc_init' [-Wmissing-prototypes]
      27 | gp10b_mc_init(struct nvkm_mc *mc)
         | ^~~~~~~~~~~~~
--
   In file included from include/linux/iommu.h:16,
                    from drivers/gpu/drm/nouveau/include/nvif/os.h:30,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/os.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/oclass.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/object.h:4,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/mmu/ummu.h:4,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c:24:
>> include/linux/ioasid.h:141:6: error: expected ';' before 'inline'
     141 | staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
         |      ^
         |      ;
   drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c:65:1: warning: no previous prototype for 'nvkm_mmu_ptp_get' [-Wmissing-prototypes]
      65 | nvkm_mmu_ptp_get(struct nvkm_mmu *mmu, u32 size, bool zero)
         | ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/iommu.h:16,
                    from drivers/gpu/drm/nouveau/include/nvif/os.h:30,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/os.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/oclass.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/device.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/subdev/mmu.h:4,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/mmu/priv.h:5,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/mmu/mem.h:3,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/mmu/tu102.c:23:
>> include/linux/ioasid.h:141:6: error: expected ';' before 'inline'
     141 | staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
         |      ^
         |      ;
   drivers/gpu/drm/nouveau/nvkm/subdev/mmu/tu102.c:31:1: warning: no previous prototype for 'tu102_mmu_kind' [-Wmissing-prototypes]
      31 | tu102_mmu_kind(struct nvkm_mmu *mmu, int *count, u8 *invalid)
         | ^~~~~~~~~~~~~~
--
   In file included from include/linux/iommu.h:16,
                    from drivers/gpu/drm/nouveau/include/nvif/os.h:30,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/os.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/oclass.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/device.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h:4,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h:27,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/therm/gt215.c:24:
>> include/linux/ioasid.h:141:6: error: expected ';' before 'inline'
     141 | staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
         |      ^
         |      ;
   drivers/gpu/drm/nouveau/nvkm/subdev/therm/gt215.c:40:1: warning: no previous prototype for 'gt215_therm_init' [-Wmissing-prototypes]
      40 | gt215_therm_init(struct nvkm_therm *therm)
         | ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/iommu.h:16,
                    from drivers/gpu/drm/nouveau/include/nvif/os.h:30,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/os.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/oclass.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/device.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/engine.h:5,
                    from drivers/gpu/drm/nouveau/include/nvkm/engine/gr.h:4,
                    from drivers/gpu/drm/nouveau/nvkm/engine/gr/priv.h:5,
                    from drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.h:27,
                    from drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:24:
>> include/linux/ioasid.h:141:6: error: expected ';' before 'inline'
     141 | staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
         |      ^
         |      ;
   drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:745:1: warning: no previous prototype for 'gf100_gr_fecs_start_ctxsw' [-Wmissing-prototypes]
     745 | gf100_gr_fecs_start_ctxsw(struct nvkm_gr *base)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:760:1: warning: no previous prototype for 'gf100_gr_fecs_stop_ctxsw' [-Wmissing-prototypes]
     760 | gf100_gr_fecs_stop_ctxsw(struct nvkm_gr *base)
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:2036:1: warning: no previous prototype for 'gf100_gr_dtor' [-Wmissing-prototypes]
    2036 | gf100_gr_dtor(struct nvkm_gr *base)
         | ^~~~~~~~~~~~~
--
   In file included from include/linux/iommu.h:16,
                    from drivers/gpu/drm/nouveau/include/nvif/os.h:30,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/os.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/oclass.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/device.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h:4,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/engine.h:5,
                    from drivers/gpu/drm/nouveau/include/nvkm/engine/gr.h:4,
                    from drivers/gpu/drm/nouveau/nvkm/engine/gr/priv.h:5,
                    from drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.h:27,
                    from drivers/gpu/drm/nouveau/nvkm/engine/gr/gk20a.c:22:
>> include/linux/ioasid.h:141:6: error: expected ';' before 'inline'
     141 | staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
         |      ^
         |      ;
   drivers/gpu/drm/nouveau/nvkm/engine/gr/gk20a.c:37:1: warning: no previous prototype for 'gk20a_gr_av_to_init' [-Wmissing-prototypes]
      37 | gk20a_gr_av_to_init(struct gf100_gr *gr, const char *path, const char *name,
         | ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/nouveau/nvkm/engine/gr/gk20a.c:87:1: warning: no previous prototype for 'gk20a_gr_aiv_to_init' [-Wmissing-prototypes]
      87 | gk20a_gr_aiv_to_init(struct gf100_gr *gr, const char *path, const char *name,
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/nouveau/nvkm/engine/gr/gk20a.c:130:1: warning: no previous prototype for 'gk20a_gr_av_to_method' [-Wmissing-prototypes]
     130 | gk20a_gr_av_to_method(struct gf100_gr *gr, const char *path, const char *name,
         | ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/iommu.h:16,
                    from drivers/gpu/drm/nouveau/include/nvif/os.h:30,
                    from drivers/gpu/drm/nouveau/include/nvif/object.h:5,
                    from drivers/gpu/drm/nouveau/include/nvif/client.h:5,
                    from drivers/gpu/drm/nouveau/nouveau_drv.h:43,
                    from drivers/gpu/drm/nouveau/nouveau_display.h:5,
                    from drivers/gpu/drm/nouveau/nouveau_fbcon.h:32,
                    from drivers/gpu/drm/nouveau/nouveau_display.c:38:
>> include/linux/ioasid.h:141:6: error: expected ';' before 'inline'
     141 | staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
         |      ^
         |      ;
   drivers/gpu/drm/nouveau/nouveau_display.c: In function 'nouveau_framebuffer_new':
   drivers/gpu/drm/nouveau/nouveau_display.c:338:15: warning: variable 'width' set but not used [-Wunused-but-set-variable]
     338 |  unsigned int width, height, i;
         |               ^~~~~
--
   In file included from include/linux/iommu.h:16,
                    from drivers/gpu/drm/nouveau/include/nvif/os.h:30,
                    from drivers/gpu/drm/nouveau/include/nvif/object.h:5,
                    from drivers/gpu/drm/nouveau/include/nvif/mmu.h:3,
                    from drivers/gpu/drm/nouveau/include/nvif/mem.h:3,
                    from drivers/gpu/drm/nouveau/dispnv50/disp.h:3,
                    from drivers/gpu/drm/nouveau/dispnv50/disp.c:24:
>> include/linux/ioasid.h:141:6: error: expected ';' before 'inline'
     141 | staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
         |      ^
         |      ;
   drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_mstm_cleanup':
   drivers/gpu/drm/nouveau/dispnv50/disp.c:1237:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    1237 |  int ret;
         |      ^~~
   drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_mstm_prepare':
   drivers/gpu/drm/nouveau/dispnv50/disp.c:1261:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    1261 |  int ret;
         |      ^~~
   drivers/gpu/drm/nouveau/dispnv50/disp.c: At top level:
   drivers/gpu/drm/nouveau/dispnv50/disp.c:2450:1: warning: no previous prototype for 'nv50_display_create' [-Wmissing-prototypes]
    2450 | nv50_display_create(struct drm_device *dev)
         | ^~~~~~~~~~~~~~~~~~~
..

# https://github.com/0day-ci/linux/commit/09f31e901946399a274ce954bdefa4108e895b33
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Jacob-Pan/IOASID-extensions-for-guest-SVA/20200822-123111
git checkout 09f31e901946399a274ce954bdefa4108e895b33
vim +141 include/linux/ioasid.h

   140	
 > 141	staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
   142	{
   143		return -ENOTSUPP;
   144	}
   145	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--y0ulUmNC+osPPQO6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
P6jS2IJHuQEA

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--y0ulUmNC+osPPQO6--
