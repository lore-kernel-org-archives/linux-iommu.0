From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/1] AMD Family15h Model10-1Fh erratum 746 Workaround
Date: Wed, 23 Jan 2013 09:07:17 -0600
Message-ID: <50FFFCA5.1010309@amd.com>
References: <1358896750-5199-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20130123070604.GT25591@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130123070604.GT25591-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: ssg.sos.staff-v4o/RmcJZDMz7H3ftjWMJQC/G2K4zDHf@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Udo van den Heuvel <udovdh-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 1/23/2013 1:06 AM, Joerg Roedel wrote:

> On Tue, Jan 22, 2013 at 05:19:10PM -0600, Suthikulpanit, Suravee wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>> @@ -1171,6 +1195,8 @@ static int iommu_init_pci(struct amd_iommu *iommu)
>>   		for (i = 0; i < 0x83; i++)
>>   			iommu->stored_l2[i] = iommu_read_l2(iommu, i);
>>   	}
>> +	
>> +	amd_iommu_apply_erratum_746(iommu);
> This will also be applied to RD890 IOMMUs, right? This workaround should
> be limited to Trinity IOMMUs.

Inside the function, it checks the family and model number.  Only Trinitiy is affected.

Suravee
