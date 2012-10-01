From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 09/16] iommu/amd: Add IOAPIC remapping routines
Date: Mon, 1 Oct 2012 18:33:38 +0200
Message-ID: <20121001163338.GP4009@amd.com>
References: <1348835046-3262-1-git-send-email-joerg.roedel@amd.com>
	<1348835046-3262-10-git-send-email-joerg.roedel@amd.com>
	<6d716497-bcf6-4d71-88a3-6ec772a4d396@sausexedgep01.amd.com>
	<20121001084051.GO4009@amd.com>
	<20121001134753.GF4099@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121001134753.GF4099-6K5HmflnPlqSPmnEAIUT9EEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 01, 2012 at 09:47:53AM -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Oct 01, 2012 at 10:40:51AM +0200, Joerg Roedel wrote:

> > Don't understand this. What is not set?
> 
> the IRQ_DELAYED_DISABLE. But I could not even find that enum anymore?
> Has that been obsoleted?

You are right, its was removed. Ok, I will remove that line of the
comment too.

> I was thinking the other way around. You recover the old affinity. Should
> you print out a warning mentioning to the system admin that you could not
> set the new affinity but reverted to the old one? Or will that not serve
> anything except spam the kernel logs?

Well, I don't think it makes sense to print an additional error at this
point. The error will be propagated upwards in the call-chain and in the
end it is up to the initiator how to handle this situation (for example
just return a failure to user-space).


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
