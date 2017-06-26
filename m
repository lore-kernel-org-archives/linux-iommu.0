From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
Date: Mon, 26 Jun 2017 14:14:30 +0200
Message-ID: <20170626121430.GX30388@8bytes.org>
References: <20170605195235.11512.52995.stgit@tlendack-t1.amdoffice.net>
	<MWHPR12MB15181A6A020ACA2F53DF70339CCB0@MWHPR12MB1518.namprd12.prod.outlook.com>
	<1496954035.4188.1.camel@rutgers.edu>
	<1498062018.17007.6.camel@rutgers.edu>
	<bf685f44-019c-4c21-25d4-6a6ea647b7cc@amd.com>
	<1498079371.17007.18.camel@rutgers.edu>
	<20170622092053.GV30388@8bytes.org>
	<1498144389.17007.25.camel@rutgers.edu>
	<20170622215735.GW30388@8bytes.org>
	<1498227647.17007.31.camel@rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498227647.17007.31.camel-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, "Nath,
	Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Craig Stein <stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 23, 2017 at 10:20:47AM -0400, Jan Vesely wrote:
> I was able to trigger "Completion-Wait loop timed out" messages in the
> following situation:
> Hung OpenCL task running on dGPU.
> dGPU goes to sleep.
> sigterm to hung task.
> it seems to recover OK after the dGPU is powered back on

How does that 'dGPU goes to sleep' work? Do you put it to sleep manually
via sysfs or something? Or is that something that amdgpu does on its
own?

It looks like the GPU just switches the ATS unit off when it goes to
sleep and doesn't answer the invalidation anymore, which explains the
completion-wait timeouts.



	Joerg
